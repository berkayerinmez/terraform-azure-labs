output "azure_firewall_public_ip" {
  value       = module.afw.azure_firewall_public_ip
  description = "Public IP address of the Azure Firewall"
}

output "azure_firewall_private_ip" {
  value       = module.afw.azure_firewall_private_ip
  description = "Private IP address of the Azure Firewall"
}