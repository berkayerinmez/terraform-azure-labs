variable "name" {
  type        = string
  description = "Traffic Manager profile name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "routing_method" {
  type        = string
  description = "Traffic routing method (e.g., Performance, Priority, Weighted)"
}

variable "dns_relative_name" {
  type        = string
  description = "DNS relative name for Traffic Manager"
}

variable "dns_ttl" {
  type        = number
  description = "DNS TTL in seconds"
  default     = 60
}

variable "monitor_protocol" {
  type        = string
  description = "Monitor protocol (HTTP or HTTPS)"
  default     = "HTTPS"
}

variable "monitor_port" {
  type        = number
  description = "Monitor port"
  default     = 443
}

variable "monitor_path" {
  type        = string
  description = "Monitor path"
  default     = "/"
}

variable "endpoints" {
  type = map(object({
    name               = string
    target_resource_id = string
  }))
  description = "Map of Azure endpoints for the Traffic Manager profile"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Traffic Manager profile"
  default     = {}
}