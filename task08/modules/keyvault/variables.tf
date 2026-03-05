variable "kv_name" {
  description = "The name of the Key Vault."
  type        = string
}

variable "location" {
  description = "The Azure region where the Key Vault will be deployed."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group containing the Key Vault."
  type        = string
}


variable "sku_name" {
  description = "The Key Vault SKU name (standard or premium)."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the Key Vault."
  type        = map(string)
  default     = {}
}