// modules/webapp/outputs.tf

output "service_plan_id" {
  description = "The ID of the App Service Plan"
  value       = azurerm_service_plan.service_plan.id
}

output "app_hostname" {
  description = "The default hostname of the Linux Web App"
  value       = azurerm_linux_web_app.linux_web_app.default_hostname
}

