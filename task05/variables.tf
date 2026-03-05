variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))
  description = "Map of resource groups to create"
}

variable "app_service_plans" {
  type = map(object({
    name         = string
    rg_key       = string
    sku_name     = string
    worker_count = number
  }))
  description = "Map of App Service Plans to create"
}

variable "app_services" {
  type = map(object({
    name    = string
    rg_key  = string
    asp_key = string
    ip_restrictions = list(object({
      name        = string
      priority    = number
      action      = string
      ip_address  = optional(string)
      service_tag = optional(string)
    }))
  }))
  description = "Map of App Services (Windows Web Apps) to create"
}

variable "traffic_manager" {
  type = object({
    name              = string
    rg_key            = string
    routing_method    = string
    dns_relative_name = string
    dns_ttl           = number
    monitor_protocol  = string
    monitor_port      = number
    monitor_path      = string
  })
  description = "Traffic Manager configuration"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}