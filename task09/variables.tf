variable "rg_name" {
  type        = string
  description = "Name of the existing resource group"
}

variable "vnet_name" {
  type        = string
  description = "Name of the existing virtual network"
}

variable "aks_snet_name" {
  type        = string
  description = "Name of the existing AKS subnet"
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the existing AKS cluster"
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "AKS load balancer public IP — set in terraform.tfvars"
}

variable "subnet_config" {
  type = object({
    address_prefixes = list(string)
  })
  description = "Configuration for the Azure Firewall subnet"
}

variable "public_ip_config" {
  type = object({
    allocation_method = string
    sku               = string
  })
  description = "Configuration for the Azure Firewall public IP"
}

variable "firewall_config" {
  type = object({
    sku_name       = string
    sku_tier       = string
    ip_config_name = string
  })
  description = "Configuration for the Azure Firewall"

}

variable "app_rule_collection" {
  type = object({
    priority = number
    action   = string
    rules = list(object({
      name             = string
      source_addresses = list(string)
      fqdn_tags        = list(string)
    }))
  })
  description = "Application rule collection configuration"
}

variable "network_rule_collection" {
  type = object({
    priority = number
    action   = string
    rules = list(object({
      name                  = string
      source_addresses      = list(string)
      destination_ports     = list(string)
      destination_addresses = list(string)
      protocols             = list(string)
    }))
  })
  description = "Network rule collection configuration"

}

variable "nat_rule_collection" {
  type = object({
    priority = number
    action   = string
    rules = list(object({
      name              = string
      source_addresses  = list(string)
      destination_ports = list(string)
      translated_port   = number
      protocols         = list(string)
    }))
  })
  description = "NAT rule collection configuration"
}

variable "prefix" {
  type        = string
  description = "Prefix for naming resources"
}

variable "fw_subnet_name" {
  type        = string
  description = "Name of the Azure Firewall subnet - Azure requires AzureFirewallSubnet"
}

variable "route_table_config" {
  type = object({
    route_name              = string
    address_prefix          = string
    next_hop_type           = string
    fw_direct_route_name    = string
    fw_direct_next_hop_type = string
  })
  description = "Configuration for the route table"
}