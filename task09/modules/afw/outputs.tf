output "azure_firewall_public_ip" {
  value       = azurerm_public_ip.ip.ip_address
  description = "Public IP address of the Azure Firewall"
}

output "azure_firewall_private_ip" {
  value       = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  description = "Private IP address of the Azure Firewall"
}