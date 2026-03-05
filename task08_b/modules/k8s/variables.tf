variable "aks_kv_access_identity_id" {
  type        = string
  description = "Client ID of the AKS CSI driver managed identity for Key Vault access"
}

variable "kv_name" {
  type        = string
  description = "Name of the Azure Key Vault to fetch secrets from"
}

variable "redis_url_secret_name" {
  type        = string
  description = "Name of the Key Vault secret storing the Redis hostname"
}

variable "redis_password_secret_name" {
  type        = string
  description = "Name of the Key Vault secret storing the Redis password"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID used in the secret provider class template"
}

variable "acr_login_server" {
  type        = string
  description = "Login server URL of the Azure Container Registry"
}

variable "app_image_name" {
  type        = string
  description = "Name of the Docker image to deploy to AKS"
}

variable "image_tag" {
  type        = string
  description = "Tag of the Docker image to deploy to AKS"
  default     = "latest"
}

variable "kubernetes_service_name" {
  type        = string
  description = "Name of the Kubernetes service to fetch the load balancer IP from"
  default     = "redis-flask-app-service"
}