output "kv_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.kv.id
}

output "kv_name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.kv.name
}

output "kv_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.kv.vault_uri
}

output "tenant_id" {
  value       = data.azurerm_client_config.current.tenant_id
  description = "Tenant ID of the current user, used for access policies in other modules"
}