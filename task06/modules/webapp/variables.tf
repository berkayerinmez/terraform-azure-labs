// modules/webapp/variables.tf

variable "sp_name" {
  description = "The name of the Service Plan."
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group."
  type        = string
}

variable "rg_location" {
  description = "The location of the Resource Group."
  type        = string
}

variable "os_type" {
  description = "The operating system type for the Service Plan."
  type        = string
}

variable "sku_name" {
  description = "The SKU name for the Service Plan."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
}

variable "web_app_name" {
  description = "The name of the Linux Web App."
  type        = string
}

variable "dotnet_version" {
  description = "The .NET version for the Linux Web App."
  type        = string
}

variable "sql_connection_string" {
  description = "SQL Database connection string"
  type        = string
  sensitive   = true
}

variable "connection_string_name" {
  description = "The name of the SQL connection string"
  type        = string
  default     = "DefaultConnection"
}
