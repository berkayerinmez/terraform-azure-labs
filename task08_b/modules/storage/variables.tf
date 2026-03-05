variable "location" {
  type        = string
  description = "Azure region where the Storage Account will be deployed"
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group where Storage Account will be created"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Storage Account"
  default     = {}
}

variable "sa_name" {
  type        = string
  description = "Name of the Azure Storage Account"
}

variable "account_tier" {
  type        = string
  description = "Performance tier of the Storage Account, Standard or Premium"
  default     = "Standard"
}

variable "account_replication_ty" {
  type        = string
  description = "Replication tip of the Storage Account e.g. LRS, GRS"
  default     = "LRS"
}

variable "container_name" {
  type        = string
  description = "Name of the blob container inside the Storage Account"
}

variable "container_access_ty" {
  type        = string
  description = "Access tip of the blob container, private, blob or container"
  default     = "private"
}

variable "blob_name" {
  type        = string
  description = "Name of the blob file uploaded to the container"
  default     = "application.tar.gz"
}

variable "sas_expiry_hours" {
  type        = number
  description = "Number of days from start time until the SAS token expires"
  default     = 1
}