# Azure Resource Group
resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location

  tags = var.tags
}

data "azurerm_client_config" "current" {}

# Key Vault Module
module "keyvault" {
  source   = "./modules/keyvault"
  kv_name  = local.keyvault_name
  location = var.location
  rg_name  = azurerm_resource_group.rg.name
  sku_name = var.kv_sku_name
  tags     = var.tags

  depends_on = [azurerm_resource_group.rg]
}

# ACR Module
module "acr" {
  source = "./modules/acr"

  acr_name         = local.acr_name
  location         = var.location
  rg_name          = azurerm_resource_group.rg.name
  sku              = var.acr_sku
  acr_task_name    = var.acr_task_name
  ctx_acs_token    = var.git_pat
  docker_ctx_path  = var.docker_ctx_path
  docker_file_path = var.docker_file_path
  app_image_name   = var.app_image_name
  os               = var.acr_os
  tags             = var.tags


  depends_on = [azurerm_resource_group.rg]
}

# Redis Cache Module
module "redis" {
  source = "./modules/redis"

  redis_cache_name  = local.redis_name
  location          = var.location
  rg_name           = azurerm_resource_group.rg.name
  capacity          = var.redis_capacity
  key_vault_id      = module.keyvault.kv_id
  redis_hostname    = var.redis_hostname
  redis_primary_key = var.redis_primary_key
  tags              = var.tags

  depends_on = [azurerm_resource_group.rg, module.keyvault]
}
# ACI Module
module "aci" {
  source = "./modules/aci"

  aci_name          = local.aci_name
  location          = var.location
  rg_name           = azurerm_resource_group.rg.name
  ip_address_type   = var.aci_ip_address_type
  dns_name_label    = var.aci_dns_name_label
  os_type           = var.aci_os_type
  container_name    = var.aci_container_name
  container_image   = var.aci_container_image
  cpu               = var.aci_cpu
  memory            = var.aci_memory
  port              = var.aci_port
  protocol          = var.aci_protocol
  registry_server   = module.acr.acr_login_server
  registry_username = module.acr.acr_admin_username
  registry_password = module.acr.acr_admin_password
  redis_url         = module.redis.redis_hostname
  redis_pwd         = module.redis.redis_primary_access_key
  tags              = var.tags

  depends_on = [azurerm_resource_group.rg, module.acr]
}

# AKS Module
module "aks" {
  source = "./modules/aks"

  aks_name              = local.aks_name
  location              = var.location
  rg_name               = azurerm_resource_group.rg.name
  aks_dns_prefix        = var.aks_dns_prefix
  aks_node_pool_name    = var.aks_node_pool_name
  aks_node_count        = var.aks_node_count
  aks_vm_size           = var.aks_vm_size
  kv_id                 = module.keyvault.kv_id
  acr_id                = module.acr.acr_id
  usr_ass_identity_name = var.aks_user_identity_name
  role_def_name         = var.aks_role_def_name
  tags                  = var.tags

  depends_on = [azurerm_resource_group.rg, module.keyvault]
}

# Configure Kubernetes Provider


# Deployment Manifest from Template
# Secret Provider Class from Template
resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
    kv_name                    = local.keyvault_name
    redis_url_secret_name      = "redis-hostname"
    redis_password_secret_name = "redis-primary-key"
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })
  depends_on = [module.aks, module.redis]
}

# Deployment Manifest from Template
resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = var.app_image_name
    image_tag        = var.image_tag
  })

  depends_on = [module.aks, kubectl_manifest.secret_provider]

  wait_for {
    field {
      key   = "status.availableReplicas"
      value = "1"
    }
  }
}

# Service Manifest
resource "kubectl_manifest" "service" {
  yaml_body  = file("${path.module}/k8s-manifests/service.yaml")
  depends_on = [kubectl_manifest.deployment]

  wait_for {
    field {
      key        = "status.loadBalancer.ingress.[0].ip"
      value      = "^(\\d+(\\.|$)){4}"
      value_type = "regex"
    }
  }
}

# Data Source to Access Kubernetes Service LoadBalancer IP
data "kubernetes_service_v1" "app_service" {
  metadata {
    name = "redis-flask-app-service"
  }

  depends_on = [kubectl_manifest.service]
}

