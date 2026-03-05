locals {
  firewall_private_ip = azurerm_firewall.fw.ip_configuration[0].private_ip_address

  subnet_name    = var.fw_subnet_name
  public_ip_name = join("-", [var.prefix, "pip"])
  fw_name        = join("-", [var.prefix, "afw"])
  rt_name        = join("-", [var.prefix, "rt"])
  fw_arc_name    = join("-", [var.prefix, "arc"])
  fw_nrc_name    = join("-", [var.prefix, "nrc"])
  fw_nat_rc_name = join("-", [var.prefix, "natrc"])
  fw_routes = [
    {
      name                   = var.route_table_config.route_name
      address_prefix         = var.route_table_config.address_prefix
      next_hop_type          = var.route_table_config.next_hop_type
      next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
    },
    {
      name                   = var.route_table_config.fw_direct_route_name
      address_prefix         = "${azurerm_public_ip.ip.ip_address}/32"
      next_hop_type          = var.route_table_config.fw_direct_next_hop_type
      next_hop_in_ip_address = null
    }
  ]
}