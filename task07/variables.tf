variable "rg_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rec_vault_name" {
  description = "Name of the Recovery Services vault"
  type        = string
}

variable "location" {
  description = "Azure region for the resources"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the virtual machine"
  type        = string
  sensitive   = true
}

variable "sa_name" {
  description = "Name of the storage account"
  type        = string
}

variable "subnet_name" {
  description = "List of subnet names to create"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the public IP address"
  type        = string
}

variable "dns_name_label" {
  description = "DNS name label for the public IP address"
  type        = string
}



variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}