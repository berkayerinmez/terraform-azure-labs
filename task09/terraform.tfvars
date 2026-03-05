prefix              = "cmtr-mod9"
rg_name             = "cmtr-mod9-rg"
vnet_name           = "cmtr-mod9-vnet"
aks_snet_name       = "aks-snet"
aks_cluster_name    = "cmtr-mod9-aks"
aks_loadbalancer_ip = "<YOUR_AKS_LB_IP>"
fw_subnet_name      = "AzureFirewallSubnet"

subnet_config = {
  address_prefixes = ["10.0.1.0/26"]
}

public_ip_config = {
  allocation_method = "Static"
  sku               = "Standard"
}

firewall_config = {
  sku_name       = "AZFW_VNet"
  sku_tier       = "Standard"
  ip_config_name = "fw-ip-config"
}

route_table_config = {
  route_name              = "fw-route"
  address_prefix          = "0.0.0.0/0"
  next_hop_type           = "VirtualAppliance"
  fw_direct_route_name    = "fw-public-ip-direct"
  fw_direct_next_hop_type = "Internet"
}

app_rule_collection = {
  priority = 100
  action   = "Allow"
  rules = [
    {
      name             = "aks-fqdn-rule"
      source_addresses = ["10.0.0.0/16"]
      fqdn_tags        = ["AzureKubernetesService"]
    }
  ]
}

network_rule_collection = {
  priority = 200
  action   = "Allow"
  rules = [
    {
      name                  = "aks-tcp-rule"
      source_addresses      = ["10.0.0.0/16"]
      destination_ports     = ["9000"]
      destination_addresses = ["AzureCloud.EastUS"]
      protocols             = ["TCP"]
    },
    {
      name                  = "aks-udp-rule"
      source_addresses      = ["10.0.0.0/16"]
      destination_ports     = ["1194"]
      destination_addresses = ["AzureCloud.EastUS"]
      protocols             = ["UDP"]
    }
  ]
}

nat_rule_collection = {
  priority = 100
  action   = "Dnat"
  rules = [
    {
      name              = "nginx-inbound-rule"
      source_addresses  = ["*"]
      destination_ports = ["80"]
      translated_port   = 80
      protocols         = ["TCP"]
    }
  ]
}
