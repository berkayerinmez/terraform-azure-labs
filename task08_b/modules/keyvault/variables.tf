variable "location" {
  type        = string
  description = "Azure region where the Key Vault will be deployed"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where Key Vault will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Key Vault"
  default     = {}
}

variable "kv_name" {
  type        = string
  description = "Name of the Azure Key Vault"
}

variable "sku_name" {
  type        = string
  description = "SKU name of the Key Vault, e.g. standard or premium"
  default     = "standard"
}

# variable "purge_protection_enabled" {
#   type        = bool
#   description = "Whether to enable purge protection on the Key Vault"
#   default     = false
# }
#
# variable "soft_delete_retention_days" {
#   type        = number
#   description = "Number of days to retain soft deleted secrets, keys and certificates"
#   default     = 7
# }

variable "secret_permissions" {
  type        = list(string)
  description = "List of secret permissions to grant to the current user access policy"
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}