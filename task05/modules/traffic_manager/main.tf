resource "azurerm_traffic_manager_profile" "tm_profile" {
  name                   = var.name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.routing_method
  tags                   = var.tags

  dns_config {
    relative_name = var.dns_relative_name
    ttl           = var.dns_ttl
  }

  monitor_config {
    protocol = var.monitor_protocol
    port     = var.monitor_port
    path     = var.monitor_path
  }
}

resource "azurerm_traffic_manager_azure_endpoint" "tm_endpoints" {
  for_each = var.endpoints

  name               = each.value.name
  profile_id         = azurerm_traffic_manager_profile.tm_profile.id
  target_resource_id = each.value.target_resource_id
}