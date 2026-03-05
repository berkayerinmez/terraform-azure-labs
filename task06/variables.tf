variable "rg_name" {
  type        = string
  description = "Name of the resource group where resources will be created."
}

variable "location" {
  type        = string
  default     = "eastus"
  description = "Azure region for all resources."
}

variable "kv_name" {
  type        = string
  description = "Name of the Key Vault to store secrets."
}

variable "kv_rg_name" {
  type        = string
  description = "Name of the resource group where the Key Vault is located."
}

variable "kv_sku_name" {
  type        = string
  default     = "standard"
  description = "SKU name for the Key Vault (e.g., standard, premium)."
}

variable "kv_secret_name" {
  type        = string
  description = "Name of the secret in Key Vault to store SQL admin password."
}

variable "sql_module" {
  type = object({
    sql_sv_name              = string
    sql_db_name              = string
    admin_username           = string
    fw_rule_name             = string
    kv_secret_admin_name     = string
    kv_secret_admin_password = string
  })
  description = "Configuration for SQL module"
}

variable "allowed_ip_address" {
  description = "Allowed IP address for SQL Server firewall"
  type        = string
}

variable "webapp_module" {
  type = object({
    sp_name        = string
    os_type        = string
    web_app_name   = string
    dotnet_version = string
    sku_name       = string
  })
  description = "Configuration for Web App module"
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  default     = {}
}

variable "resource_name_prefix" {
  type        = string
  description = "Prefix for resource names to ensure uniqueness."
}
