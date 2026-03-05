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
