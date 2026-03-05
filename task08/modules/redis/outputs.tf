output "redis_id" {
  description = "The ID of the Azure Redis Cache instance."
  value       = azurerm_redis_cache.redis.id
}

output "redis_hostname" {
  description = "The hostname of the Azure Redis Cache instance."
  value       = azurerm_redis_cache.redis.hostname
  sensitive   = true
}

output "redis_primary_access_key" {
  description = "The primary access key of the Azure Redis Cache instance."
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "redis_hostname_secret_id" {
  description = "The ID of the Key Vault secret containing the Redis hostname."
  value       = azurerm_key_vault_secret.redis_hostname.id
}

output "redis_primary_key_secret_id" {
  description = "The ID of the Key Vault secret containing the Redis primary access key."
  value       = azurerm_key_vault_secret.redis_primary_key.id
}

