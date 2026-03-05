variable "location" {
  description = "The Azure region where the container instance will be deployed."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group in which to create the container instance."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the container instance."
  type        = map(string)
  default     = {}
}

variable "acr_name" {
  description = "..."
  type        = string
}

variable "sku" {
  description = "..."
  type        = string
}

variable "acr_task_name" {
  description = "..."
  type        = string
}

variable "ctx_acs_token" {
  description = "Token used to store AVS."
  type        = string
}

variable "docker_ctx_path" {
  description = "The path that should be used for the docker_ctx path."
  type        = string
}

variable "docker_file_path" {
  description = "The path that should be used for the docker_ctx file."
  type        = string
}

variable "os" {
  description = "The operating system for the ACR task."
  type        = string
}

variable "app_image_name" {
  description = "The name of the image to be built and pushed to ACR."
  type        = string
}