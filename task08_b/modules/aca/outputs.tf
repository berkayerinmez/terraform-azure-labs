output "aca_fqdn" {
  value       = azurerm_container_app.aca.latest_revision_fqdn
  description = "FQDN of the Azure Container App used to access the application via DNS"
}

output "aca_identity_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.id
  description = "Resource ID of the user assigned managed identity for the Container App"
}

output "aca_identity_principal_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  description = "Principal ID of the user assigned managed identity, used for role assignments"
}

output "aca_identity_tenant_id" {
  value       = azurerm_user_assigned_identity.user_assigned_identity.tenant_id
  description = "Tenant ID of the user assigned managed identity"
}