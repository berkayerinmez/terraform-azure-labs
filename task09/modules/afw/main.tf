resource "azurerm_subnet" "snet" {
  name                 = local.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_config.address_prefixes
}

resource "azurerm_public_ip" "ip" {
  name                = local.public_ip_name
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = var.public_ip_config.allocation_method
  sku                 = var.public_ip_config.sku

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "fw" {
  name                = local.fw_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = var.firewall_config.sku_name
  sku_tier            = var.firewall_config.sku_tier

  ip_configuration {
    name                 = var.firewall_config.ip_config_name
    subnet_id            = azurerm_subnet.snet.id
    public_ip_address_id = azurerm_public_ip.ip.id
  }
}

resource "azurerm_route_table" "route_table" {
  name                = local.rt_name
  location            = var.location
  resource_group_name = var.rg_name

  dynamic "route" {
    for_each = local.fw_routes
    content {
      name                   = route.value.name
      address_prefix         = route.value.address_prefix
      next_hop_type          = route.value.next_hop_type
      next_hop_in_ip_address = try(route.value.next_hop_in_ip_address, null)
    }
  }
}

resource "azurerm_subnet_route_table_association" "snet_rt_assoc" {
  subnet_id      = var.aks_snet_id
  route_table_id = azurerm_route_table.route_table.id
}

resource "azurerm_firewall_application_rule_collection" "fw_arc" {
  name                = local.fw_arc_name
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = var.rg_name
  priority            = var.app_rule_collection.priority
  action              = var.app_rule_collection.action

  dynamic "rule" {
    for_each = var.app_rule_collection.rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      fqdn_tags        = rule.value.fqdn_tags
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "fw_net_rc" {
  name                = local.fw_nrc_name
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = var.rg_name
  priority            = var.network_rule_collection.priority
  action              = var.network_rule_collection.action

  dynamic "rule" {
    for_each = var.network_rule_collection.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      protocols             = rule.value.protocols
    }
  }
}

resource "azurerm_firewall_nat_rule_collection" "fw_nat_rc" {
  name                = local.fw_nat_rc_name
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = var.rg_name
  priority            = var.nat_rule_collection.priority
  action              = var.nat_rule_collection.action

  dynamic "rule" {
    for_each = var.nat_rule_collection.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      destination_ports     = rule.value.destination_ports
      destination_addresses = [azurerm_public_ip.ip.ip_address]
      translated_port       = rule.value.translated_port
      translated_address    = var.aks_loadbalancer_ip
      protocols             = rule.value.protocols
    }
  }
}