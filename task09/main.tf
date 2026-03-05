data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_snet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

module "afw" {
  source                  = "./modules/afw"
  prefix                  = local.prefix
  rg_name                 = data.azurerm_resource_group.rg.name
  location                = data.azurerm_resource_group.rg.location
  vnet_name               = data.azurerm_virtual_network.vnet.name
  aks_snet_id             = data.azurerm_subnet.aks_subnet.id
  aks_loadbalancer_ip     = var.aks_loadbalancer_ip
  fw_subnet_name          = var.fw_subnet_name
  subnet_config           = var.subnet_config
  public_ip_config        = var.public_ip_config
  firewall_config         = var.firewall_config
  route_table_config      = var.route_table_config
  app_rule_collection     = var.app_rule_collection
  network_rule_collection = var.network_rule_collection
  nat_rule_collection     = var.nat_rule_collection
}