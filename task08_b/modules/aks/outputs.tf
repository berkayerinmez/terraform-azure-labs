output "aks_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "Resource ID of the AKS cluster"
}

output "host" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  description = "Kubernetes API server endpoint"
  sensitive   = true
}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  description = "Client certificate for authenticating to the Kubernetes API server"
  sensitive   = true
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  description = "Client key for authenticating to the Kubernetes API server"
  sensitive   = true
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate
  description = "Cluster CA certificate for authenticating to the Kubernetes API server"
  sensitive   = true
}

output "aks_kv_access_identity_id" {
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
  description = "Client ID of the AKS CSI driver managed identity used to access Key Vault"
}