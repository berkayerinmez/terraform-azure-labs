// modules/sql/variables.tf
variable "rg_location" {
  type        = string
  description = "Location for all resources."
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where the SQL resources will be created."
}

variable "kv_secret_admin_name" {
  type        = string
  description = "The name of the Key Vault secret to store the SQL admin username."
}

variable "kv_secret_admin_password" {
  type        = string
  description = "The name of the Key Vault secret to store the SQL admin password."
}

variable "kv_id" {
  type        = string
  description = "The ID of the existing Key Vault."
}

variable "sql_db_name" {
  type        = string
  description = "The name of the SQL Database."
}

variable "sql_sv_name" {
  type        = string
  description = "The name of the SQL Server."
}

variable "admin_username" {
  type        = string
  description = "The administrator username of the SQL logical server."
}

variable "kv_rg_name" {
  type        = string
  description = "The name of the resource group where the existing Key Vault is located."
}

variable "kv_name" {
  type        = string
  description = "The name of the existing Key Vault."
}

variable "fw_rule_name" {
  type        = string
  description = "The name of the SQL firewall rule."
}

variable "allowed_ip_address" {
  description = "Allowed IP address for SQL Server firewall"
  type        = string
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the resources."
  default     = {}
}
