variable "redis_cache_name" {
  description = "The name of the Azure Redis Cache instance."
  type        = string
}

variable "location" {
  description = "The Azure region where the Redis Cache will be deployed."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group containing the Redis Cache."
  type        = string
}

variable "capacity" {
  description = "The size of the Redis Cache (0, 1, 2, 3, 4, 5, 6)."
  type        = number
}

variable "key_vault_id" {
  description = "The ID of the Key Vault where secrets will be stored."
  type        = string
}

variable "redis_hostname" {
  description = "The name of the Key Vault secret to store the Redis hostname."
  type        = string
}

variable "redis_primary_key" {
  description = "The name of the Key Vault secret to store the Redis primary access key."
  type        = string
}

variable "sku_name" {
  description = "The SKU name of the Redis Cache (e.g., Basic, Standard, Premium)."
  type        = string
  default     = "Basic"
}

variable "family" {
  description = "The family of the Redis Cache (e.g., C for Basic, P for Premium)."
  type        = string
  default     = "C"
}

variable "tags" {
  description = "A map of tags to assign to the Redis Cache and related resources."
  type        = map(string)
  default     = {}
}