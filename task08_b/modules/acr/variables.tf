variable "location" {
  type        = string
  description = "Azure region where the Container Registry resources will be deployed"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where Container Registry will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all Container Registry resources"
  default     = {}
}

# ACR
variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry"
}

variable "sku" {
  type        = string
  description = "SKU of the Azure Container Registry, e.g. Basic, Standard, Premium"
  default     = "Basic"
}

variable "admin_enabled" {
  type        = bool
  description = "Whether to enable admin user for the Azure Container Registry"
  default     = true
}

# ACR Task
variable "acr_task_name" {
  type        = string
  description = "Name of the ACR task used to build and push the Docker image"
  default     = "acr-build-task"
}

variable "platform_config" {
  type = object({
    os           = string
    architecture = string
  })
  description = "Platform configuration for the ACR task including OS and architecture"
  default = {
    os           = "Linux"
    architecture = "amd64"
  }
}

variable "blob_url" {
  type        = string
  description = "Blob URL of the application archive in Storage Account, used as context_path for the ACR task"
}

variable "sas_token" {
  type        = string
  sensitive   = true
  description = "SAS token for the Storage Account Blob Container, used as context_access_token for the ACR task"
}

variable "dockerfile_path" {
  type        = string
  description = "Path to the Dockerfile inside the archive, relative to the context root"
  default     = "Dockerfile"
}

variable "app_image_name" {
  type        = string
  description = "Name of the Docker image to build and push to the Container Registry"
}

variable "image_tag" {
  type        = string
  description = "Tag to apply to the built Docker image"
  default     = "latest"
}

variable "push_enabled" {
  type        = bool
  description = "Whether to push the built image to the Container Registry after building"
  default     = true
}