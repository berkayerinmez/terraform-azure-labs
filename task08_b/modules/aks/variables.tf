variable "location" {
  type        = string
  description = "Azure region where the AKS cluster will be deployed"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where AKS will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the AKS cluster"
  default     = {}
}

variable "aks_name" {
  type        = string
  description = "Name of the Azure Kubernetes Service cluster"
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the AKS cluster"
}

variable "node_pool_config" {
  type = object({
    name            = string
    node_count      = number
    vm_size         = string
    os_disk_ty      = string
    os_disk_size_gb = number
  })
  description = "Configuration for the default node pool including name, node count, VM size, and disk settings"
  default = {
    name            = "system"
    node_count      = 1
    vm_size         = "Standard_D2ads_v6"
    os_disk_ty      = "Ephemeral"
    os_disk_size_gb = 75
  }
}

variable "secret_rotation_enabled" {
  type        = bool
  description = "Whether to enable secret rotation for the Key Vault secrets provider"
  default     = true
}

variable "secret_rotation_interval" {
  type        = string
  description = "Interval at which secrets should be rotated, e.g. 2m"
  default     = "2m"
}

variable "acr_id" {
  type        = string
  description = "Resource ID of the Azure Container Registry to allow AKS to pull images from"
}

variable "acr_role_definition_name" {
  type        = string
  description = "Role definition name to assign to AKS kubelet identity for ACR access"
  default     = "AcrPull"
}

variable "kv_id" {
  type        = string
  description = "Resource ID of the Azure Key Vault to allow AKS CSI driver to access secrets"
}

variable "kv_secret_permissions" {
  type        = list(string)
  description = "List of secret permissions to grant to AKS CSI driver identity on Key Vault"
  default     = ["Get"]
}