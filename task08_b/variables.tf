# General
variable "location" {
  type        = string
  description = "Azure region where all resources will be deployed"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}

variable "name_prefix" {
  type        = string
  description = "Prefix used to generate all resource names via locals"
}

# Key Vault
variable "kv_sku_name" {
  type        = string
  description = "SKU name of the Azure Key Vault"
  default     = "standard"
}

# Storage Account
variable "account_replication_ty" {
  type        = string
  description = "Replication typ of the Storage Account"
  default     = "LRS"
}

variable "storage_container_name" {
  type        = string
  description = "Name of the blob container inside the Storage Account"
}

variable "container_access_ty" {
  type        = string
  description = "Access typ of the blob container"
  default     = "private"
}

# ACI Redis
variable "aci_dns_name_label" {
  type        = string
  description = "DNS name label for the Redis Azure Container Instance"
}

variable "aci_container_name" {
  type        = string
  description = "Name of the Redis container inside the container group"
}

variable "aci_container_image" {
  type        = string
  description = "Docker image to use for the Redis container, should be from Microsoft Artifact Registry"
}

variable "redis_hostname_secret_name" {
  type        = string
  description = "Name of the Key Vault secret storing the Redis hostname"
  default     = "redis-hostname"
}

variable "redis_password_secret_name" {
  type        = string
  description = "Name of the Key Vault secret storing the Redis password"
  default     = "redis-password"
}

# ACR
variable "acr_sku" {
  type        = string
  description = "SKU of the Azure Container Registry"
  default     = "Basic"
}

variable "acr_task_name" {
  type        = string
  description = "Name of the ACR task used to build the Docker image"
}

variable "app_image_name" {
  type        = string
  description = "Name of the Docker image to build and deploy"
}

# AKS
variable "aks_node_pool_name" {
  type        = string
  description = "Name of the default AKS node pool"
  default     = "system"
}

variable "aks_node_count" {
  type        = number
  description = "Number of nodes in the default AKS node pool"
  default     = 1
}

variable "aks_vm_size" {
  type        = string
  description = "VM size for the default AKS node pool"
  default     = "Standard_D2ads_v6"
}

variable "aks_os_disk_ty" {
  type        = string
  description = "OS disk typ for the default AKS node pool"
  default     = "Ephemeral"
}

variable "aks_os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB for the default AKS node pool"
  default     = 75
}

# ACA
variable "aca_identity_name" {
  type        = string
  description = "Name of the user assigned identity for the Azure Container App"
}

variable "workload_profiles" {
  type = list(object({
    name          = string
    tip           = string
    minimum_count = optional(number)
    maximum_count = optional(number)
  }))
  description = "Workload profiles for the Azure Container App Environment"
  default = [
    {
      name          = "Consumption"
      tip           = "Consumption"
      minimum_count = null
      maximum_count = null
    }
  ]
}

variable "secret_redis_url_name" {
  type        = string
  description = "Name of the ACA secret referencing Redis hostname KV secret"
  default     = "redis-url"
}

variable "secret_redis_key_name" {
  type        = string
  description = "Name of the ACA secret referencing Redis password KV secret"
  default     = "redis-key"
}

variable "aca_env_vars" {
  type = list(object({
    name        = string
    value       = optional(string)
    secret_name = optional(string)
  }))
  description = "Environment variables for the Azure Container App"
}

