resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.aks_dns_prefix

  default_node_pool {
    name            = var.aks_node_pool_name
    node_count      = var.aks_node_count
    vm_size         = var.aks_vm_size
    os_disk_type    = "Ephemeral"
    os_disk_size_gb = 75
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  tags = var.tags
}

resource "azurerm_user_assigned_identity" "ass_identity" {
  name                = var.usr_ass_identity_name
  resource_group_name = var.rg_name
  location            = var.location
}

# Allow AKS to pull images from ACR
resource "azurerm_role_assignment" "role_assignment" {
  scope                = var.acr_id
  role_definition_name = var.role_def_name
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

# Allow AKS to get secrets from Key Vault
resource "azurerm_key_vault_access_policy" "aks_kv_policy" {
  key_vault_id = var.kv_id
  tenant_id    = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
  object_id    = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].object_id

  secret_permissions = ["Get"]
}