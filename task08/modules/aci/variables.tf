variable "aci_name" {
  description = "The name of the Azure Container Instance."
  type        = string
}

variable "location" {
  description = "The Azure region where the container instance will be deployed."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group in which to create the container instance."
  type        = string
}

variable "ip_address_type" {
  description = "The type of IP address to assign to the container instance (e.g., 'Public' or 'Private')."
  type        = string
}

variable "dns_name_label" {
  description = "The DNS name label for the container instance, which will be used to create a fully qualified domain name (FQDN)."
  type        = string
}

variable "os_type" {
  description = "The operating system type for the container instance (e.g., 'Linux' or 'Windows')."
  type        = string
}

variable "container_name" {
  description = "The name of the container within the container instance."
  type        = string
}

variable "container_image" {
  description = "The container image to use for the container instance (e.g., 'nginx:latest')."
  type        = string
}

variable "cpu" {
  description = "The number of CPU cores to allocate to the container instance."
  type        = number
}

variable "memory" {
  description = "The amount of memory (in GB) to allocate to the container instance."
  type        = number
}

variable "port" {
  description = "The port number to expose on the container instance."
  type        = number
}

variable "protocol" {
  description = "The protocol to use for the exposed port (e.g., 'TCP' or 'UDP')."
  type        = string
}

variable "registry_server" {
  description = "The server address of the container registry (e.g., 'myregistry.azurecr.io')."
  type        = string
}

variable "registry_username" {
  description = "The username for authenticating with the container registry."
  type        = string
}

variable "registry_password" {
  description = "The password for authenticating with the container registry."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "A map of tags to assign to the container instance."
  type        = map(string)
  default     = {}
}

variable "redis_url" {
  description = "Redis hostname for the container instance."
  type        = string
  sensitive   = true
}

variable "redis_pwd" {
  description = "Redis primary access key for the container instance."
  type        = string
  sensitive   = true
}

