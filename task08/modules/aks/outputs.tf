output "aks_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "aks_fqdn" {
  description = "The FQDN of the AKS API server."
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_kube_config_raw" {
  description = "The raw kubeconfig for the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "aks_node_resource_group" {
  description = "The auto-created node resource group for AKS."
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "user_assigned_identity_principal_id" {
  description = "The principal ID of the user-assigned identity."
  value       = azurerm_user_assigned_identity.ass_identity.principal_id
}

output "aks_kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config
  sensitive = true
}

output "aks_kv_access_identity_id" {
  value = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
}