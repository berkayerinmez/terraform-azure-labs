variable "name" {
  type        = string
  description = "App Service Plan name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region location"
}

variable "sku_name" {
  type        = string
  description = "SKU name for the App Service Plan"
}

variable "worker_count" {
  type        = number
  description = "Number of workers (instances)"
  default     = 1
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the App Service Plan"
  default     = {}
}