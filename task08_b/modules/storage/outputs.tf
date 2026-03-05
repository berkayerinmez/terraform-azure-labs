output "blob_url" {
  value       = "${azurerm_storage_account.sa.primary_blob_endpoint}${azurerm_storage_container.container.name}/${azurerm_storage_blob.blob.name}"
  description = "Full URL of the uploaded blob, used as context_path in ACR task"
}

output "sas_token" {
  value       = data.azurerm_storage_account_blob_container_sas.sas.sas
  description = "SAS token for the blob container, used as context_access_token in ACR task"
  sensitive   = true
}