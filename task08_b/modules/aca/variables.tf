variable "location" {
  type        = string
  description = "Azure region where the Container App resources will be deployed"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where Container App resources will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all Container App resources"
  default     = {}
}

# Identity
variable "user_assigned_identity_name" {
  type        = string
  description = "Name of the user assigned managed identity for the Container App"
}

# Key Vault
variable "kv_id" {
  type        = string
  description = "Resource ID of the Key Vault to grant the Container App access to"
}

variable "kv_secret_permissions" {
  type        = list(string)
  description = "List of secret permissions to grant to the Container App identity on Key Vault"
  default     = ["Get"]
}

# Secrets
variable "secrets" {
  type = list(object({
    name                = string
    key_vault_secret_id = string
  }))
  description = "List of secrets to configure in the Container App, each referencing a Key Vault secret ID"
  default     = []
}

# ACR
variable "acr_id" {
  type        = string
  description = "Resource ID of the Azure Container Registry to allow the Container App to pull images from"
}

variable "acr_login_server" {
  type        = string
  description = "Login server URL of the Azure Container Registry"
}

variable "acr_role_definition_name" {
  type        = string
  description = "Role definition name to assign to the Container App identity for ACR access"
  default     = "AcrPull"
}

# Container App Environment
variable "aca_environment_name" {
  type        = string
  description = "Name of the Azure Container App Environment"
}

variable "workload_profiles" {
  type = list(object({
    name          = string
    tip           = string
    minimum_count = optional(number)
    maximum_count = optional(number)
  }))
  description = "Workload profiles to configure on the Container App Environment"
  default = [
    {
      name          = "Consumption"
      tip           = "Consumption"
      minimum_count = null
      maximum_count = null
    }
  ]
}

# Container App
variable "aca_name" {
  type        = string
  description = "Name of the Azure Container App"
}

variable "revision_mode" {
  type        = string
  description = "Revision mode for the Container App, Single or Multiple"
  default     = "Single"
}

variable "app_image_name" {
  type        = string
  description = "Name of the Docker image to deploy in the Container App"
}

variable "image_tag" {
  type        = string
  description = "Tag of the Docker image to deploy in the Container App"
  default     = "latest"
}

variable "container_config" {
  type = object({
    name         = string
    cpu          = number
    memory       = string
    min_replicas = number
    max_replicas = number
  })
  description = "Configuration for the container including name, CPU, memory and replica counts"
  default = {
    name         = "redis-flask-app"
    cpu          = 0.25
    memory       = "0.5Gi"
    min_replicas = 1
    max_replicas = 1
  }
}

variable "env_vars" {
  type = list(object({
    name        = string
    value       = optional(string)
    secret_name = optional(string)
  }))
  description = "Environment variables for the Container App, value and secret_name are mutually exclusive per var"
  default     = []
}

# Ingress
variable "ingress_config" {
  type = object({
    external_enabled   = bool
    target_port        = number
    traffic_percentage = number
  })
  description = "Ingress configuration for the Container App including external access, target port and traffic weight"
  default = {
    external_enabled   = true
    target_port        = 8080
    traffic_percentage = 100
  }
}