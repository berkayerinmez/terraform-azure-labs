// All variable declarations should be defined here.
// Types must be specified — if no default is set, the value must be provided in .tfvars.

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "the name of the vn"
  type        = string
}

variable "subnet_name" {
  description = "subnet names"
  type        = string

}

variable "network_interface_name" {
  description = "name of the network interface"
  type        = string
}

variable "nsg_name" {
  description = "name of the network security group"
  type        = string
}

variable "nsg_inbound_http_rule" {
  description = "name of the nsg inbound http rule"
  type        = string
}

variable "nsg_inbound_ssh_rule" {
  description = "name of the nsg inbound ssh rule"
  type        = string
}

variable "public_ip_name" {
  description = "name of the public ip"
  type        = string
}

variable "dns_name_label" {
  description = "dns name label for public ip"
  type        = string
}

variable "vm_name" {
  description = "name of the virtual machine"
  type        = string
}

variable "vm_os_version" {
  description = "the os version of the vm"
  type        = string
}

variable "vm_sku" {
  description = "the sku of the vm"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}

variable "subscription_id" {
  description = "The Subscription ID for the AzureRM Provider"
  type        = string

}

variable "vm_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "vm_password" {
  description = "The admin password for the virtual machine"
  type        = string
  sensitive   = true
}

variable "nic_ip_configuration_name" {
  description = "The name of the IP configuration for the network interface"
  type        = string
}
