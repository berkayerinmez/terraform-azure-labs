data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "keyvault" {
  source   = "./modules/keyvault"
  kv_name  = local.keyvault_name
  rg_name  = azurerm_resource_group.rg.name
  location = var.location
  sku_name = var.kv_sku_name
  tags     = var.tags
}

module "storage" {
  source                 = "./modules/storage"
  sa_name                = local.sa_name
  location               = var.location
  rg_name                = azurerm_resource_group.rg.name
  account_replication_ty = var.account_replication_ty
  container_name         = var.storage_container_name
  container_access_ty    = var.container_access_ty
  tags                   = var.tags
}

module "aci_redis" {
  source                     = "./modules/aci_redis"
  aci_name                   = local.redis_aci_name
  location                   = var.location
  rg_name                    = azurerm_resource_group.rg.name
  dns_name_label             = var.aci_dns_name_label
  container_name             = var.aci_container_name
  container_image            = var.aci_container_image
  key_vault_id               = module.keyvault.kv_id
  redis_hostname_secret_name = var.redis_hostname_secret_name
  redis_password_secret_name = var.redis_password_secret_name
  tags                       = var.tags

  depends_on = [module.keyvault]
}

module "acr" {
  source         = "./modules/acr"
  acr_name       = local.acr_name
  acr_task_name  = var.acr_task_name
  location       = var.location
  rg_name        = azurerm_resource_group.rg.name
  sku            = var.acr_sku
  blob_url       = module.storage.blob_url
  sas_token      = module.storage.sas_token
  app_image_name = var.app_image_name
  tags           = var.tags

  depends_on = [module.storage]
}

module "aks" {
  source     = "./modules/aks"
  aks_name   = local.aks_name
  location   = var.location
  rg_name    = azurerm_resource_group.rg.name
  dns_prefix = "${local.aks_name}-dns"
  node_pool_config = {
    name            = var.aks_node_pool_name
    node_count      = var.aks_node_count
    vm_size         = var.aks_vm_size
    os_disk_ty      = var.aks_os_disk_ty
    os_disk_size_gb = var.aks_os_disk_size_gb
  }
  acr_id = module.acr.acr_id
  kv_id  = module.keyvault.kv_id
  tags   = var.tags

  depends_on = [module.keyvault, module.acr]
}

module "aca" {
  source                      = "./modules/aca"
  aca_name                    = local.aca_name
  aca_environment_name        = local.aca_env_name
  rg_name                     = azurerm_resource_group.rg.name
  location                    = var.location
  user_assigned_identity_name = var.aca_identity_name
  kv_id                       = module.keyvault.kv_id
  app_image_name              = var.app_image_name
  acr_id                      = module.acr.acr_id
  acr_login_server            = module.acr.acr_login_server
  workload_profiles           = var.workload_profiles
  env_vars                    = var.aca_env_vars
  secrets = [
    {
      name                = var.secret_redis_url_name
      key_vault_secret_id = module.aci_redis.redis_hostname_secret_id
    },
    {
      name                = var.secret_redis_key_name
      key_vault_secret_id = module.aci_redis.redis_password_secret_id
    }
  ]
  tags = var.tags

  depends_on = [module.keyvault, module.aci_redis, module.acr]
}

module "k8s" {
  source                     = "./modules/k8s"
  aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
  kv_name                    = module.keyvault.kv_name
  redis_url_secret_name      = var.redis_hostname_secret_name
  redis_password_secret_name = var.redis_password_secret_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  acr_login_server           = module.acr.acr_login_server
  app_image_name             = var.app_image_name

  depends_on = [module.aks, module.acr, module.aci_redis]
}