output "id" {
  value       = azurerm_windows_web_app.app.id
  description = "Windows Web App ID"
}

output "name" {
  value       = azurerm_windows_web_app.app.name
  description = "Windows Web App name"
}

output "default_hostname" {
  value       = azurerm_windows_web_app.app.default_hostname
  description = "Default hostname of the Windows Web App"
}