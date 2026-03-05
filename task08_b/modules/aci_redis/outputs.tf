output "redis_fqdn" {
  value       = azurerm_container_group.aci.fqdn
  description = "FQDN of the Redis Azure Container Instance used to connect to Redis via DNS name"
}

output "redis_ip" {
  value       = azurerm_container_group.aci.ip_address
  description = "Public IP address of the Redis Azure Container Instance"
}

output "redis_password" {
  value       = random_password.redis_password.result
  sensitive   = true
  description = "Randomly generated Redis password, stored securely in Key Vault"
}

output "redis_hostname_secret_id" {
  value       = azurerm_key_vault_secret.redis_hostname.versionless_id
  description = "Versionless ID of the Key Vault secret storing the Redis hostname, used by ACA and AKS to reference the secret"
}

output "redis_password_secret_id" {
  value       = azurerm_key_vault_secret.redis_password.versionless_id
  description = "Versionless ID of the Key Vault secret storing the Redis password, used by ACA and AKS to reference the secret"
}