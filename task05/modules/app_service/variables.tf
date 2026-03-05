variable "name" {
  type        = string
  description = "Windows Web App name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Azure region location"
}

variable "service_plan_id" {
  type        = string
  description = "App Service Plan ID"
}

variable "ip_restrictions" {
  type = list(object({
    name        = string
    priority    = number
    action      = string
    ip_address  = optional(string)
    service_tag = optional(string)
  }))
  description = "IP restriction rules for the web app"
  default     = []
}

variable "ip_restriction_default_action" {
  type        = string
  description = "Default action for IP restrictions (Allow or Deny)"
  default     = "Deny"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Windows Web App"
  default     = {}
}