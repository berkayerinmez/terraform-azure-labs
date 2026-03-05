output "fqdn" {
  value       = azurerm_traffic_manager_profile.tm_profile.fqdn
  description = "Traffic Manager profile FQDN"
}

output "id" {
  value       = azurerm_traffic_manager_profile.tm_profile.id
  description = "Traffic Manager profile ID"
}