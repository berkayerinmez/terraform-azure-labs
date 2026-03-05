// butun degerler burda olmalı
// tipleri belirtilmeli... default yoksa .tfvars a koyulmalı

variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
}

variable "storageaccount_name" {
  description = "Name of the Azure storage account"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Common tags applied to resources"
  type        = map(string)
}



variable "virtual_network_name" {
  description = "the name of the vn"
  type        = string
}

variable "subnet_names" {
  description = "subnet names"
  type        = list(string)

}

variable "subscription_id" {
  description = "The Subscription ID for the AzureRM Provider"
  type        = string

}