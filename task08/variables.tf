# Resource Group Variables
variable "resource_group_name" {
  description = "The name of the Azure Resource Group."
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be deployed."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "kv_sku_name" {
  description = "The Key Vault SKU name (standard or premium)."
  type        = string
  default     = "standard"
}

# Azure Container Registry (ACR) Variables
variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "acr_sku" {
  description = "The SKU name of the Azure Container Registry."
  type        = string
  default     = "Standard"
}

variable "acr_task_name" {
  description = "The name of the ACR task."
  type        = string
}

variable "git_pat" {
  description = "The access token for accessing the docker context."
  type        = string
  sensitive   = true
}

variable "docker_ctx_path" {
  description = "The path to the docker context (GitHub repository)."
  type        = string
}

variable "docker_file_path" {
  description = "The path to the Dockerfile."
  type        = string
}

variable "acr_os" {
  description = "The operating system for the ACR task."
  type        = string
  default     = "Linux"
}



# Redis Cache Variables
variable "redis_cache_name" {
  description = "The name of the Azure Redis Cache instance."
  type        = string
}

variable "redis_capacity" {
  description = "The size of the Redis Cache (0, 1, 2, 3, 4, 5, 6)."
  type        = number
  default     = 0
}

# Azure Container Instance (ACI) Variables
variable "aci_name" {
  description = "The name of the Azure Container Instance."
  type        = string
}

variable "aci_ip_address_type" {
  description = "The type of IP address for the ACI (Public or Private)."
  type        = string
  default     = "Public"
}

variable "aci_dns_name_label" {
  description = "The DNS name label for the ACI."
  type        = string
}

variable "aci_os_type" {
  description = "The operating system type for the ACI."
  type        = string
  default     = "Linux"
}

variable "aci_container_name" {
  description = "The name of the container in the ACI."
  type        = string
}

variable "aci_container_image" {
  description = "The container image to use for the ACI."
  type        = string
}

variable "aci_cpu" {
  description = "The number of CPU cores for the ACI."
  type        = number
  default     = 1.0
}

variable "aci_memory" {
  description = "The amount of memory (in GB) for the ACI."
  type        = number
  default     = 1.5
}

variable "aci_port" {
  description = "The port exposed by the ACI container."
  type        = number
  default     = 80
}

variable "aci_protocol" {
  description = "The protocol for the ACI port."
  type        = string
  default     = "TCP"
}

# Azure Kubernetes Service (AKS) Variables
variable "aks_name" {
  description = "The name of the Azure Kubernetes Service cluster."
  type        = string
}

variable "aks_dns_prefix" {
  description = "The DNS prefix for the AKS cluster."
  type        = string
}

variable "aks_node_pool_name" {
  description = "The name of the default AKS node pool."
  type        = string
}

variable "aks_node_count" {
  description = "The number of nodes in the AKS cluster."
  type        = number
  default     = 1
}

variable "aks_vm_size" {
  description = "The VM size for AKS nodes."
  type        = string
  default     = "Standard_B2s"
}

variable "aks_user_identity_name" {
  description = "The name of the user-assigned identity for AKS."
  type        = string
}

variable "aks_role_def_name" {
  description = "The role definition name for AKS identity."
  type        = string
}

# Kubernetes Deployment Variables
variable "app_image_name" {
  description = "The name of the application image in ACR."
  type        = string
}

variable "image_tag" {
  description = "The tag of the application image."
  type        = string
  default     = "latest"
}

variable "name_prefix" {
  description = "Base prefix for resource names (e.g., cmtr-04f2gwa7-mod8)."
  type        = string
}

variable "redis_hostname" {
  description = "The name of the Key Vault secret to store the Redis hostname."
  type        = string
  default     = "redis-hostname"
}

variable "redis_primary_key" {
  description = "The name of the Key Vault secret to store the Redis primary access key."
  type        = string
  default     = "redis-primary-key"
}