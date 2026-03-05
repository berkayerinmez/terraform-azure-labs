variable "aks_name" {
  description = "The name of the Azure Kubernetes Service (AKS) cluster."
  type        = string
}

variable "location" {
  description = "The Azure region where the AKS cluster will be deployed."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group that will contain the AKS cluster."
  type        = string
}

variable "aks_dns_prefix" {
  description = "The DNS prefix to use for the AKS cluster."
  type        = string
}

variable "aks_node_pool_name" {
  description = "The name of the default node pool."
  type        = string
}

variable "aks_node_count" {
  description = "The number of nodes in the default node pool."
  type        = number
}

variable "aks_vm_size" {
  description = "The VM size for nodes in the default node pool."
  type        = string
}

variable "kv_id" {
  description = "The Azure Key Vault key ID used by the key management service."
  type        = string
}

variable "usr_ass_identity_name" {
  description = "The name of the user-assigned identity for DNS zone access."
  type        = string
}

variable "role_def_name" {
  description = "The role definition name for the DNS zone role assignment."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the AKS cluster."
  type        = map(string)
  default     = {}
}

variable "os_disk_type" {
  description = "os disk type"
  type        = string
  default     = "Ephemeral"
}

variable "acr_id" {
  description = "acr id"
  type        = string
}