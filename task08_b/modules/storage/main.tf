data "archive_file" "app_archive" {
  type        = "tar.gz"
  source_dir  = "${path.root}/application"
  output_path = "${path.root}/application.tar.gz"
}

resource "time_static" "sas_start" {}

resource "time_offset" "sas_expiry" {
  base_rfc3339 = time_static.sas_start.rfc3339
  offset_hours = var.sas_expiry_hours
}

resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  location                 = var.location
  resource_group_name      = var.rg_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_ty
  tags                     = var.tags
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = var.container_access_ty
}

resource "azurerm_storage_blob" "blob" {
  name                   = var.blob_name
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = data.archive_file.app_archive.output_path
  content_md5            = data.archive_file.app_archive.output_md5
}

data "azurerm_storage_account_blob_container_sas" "sas" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  container_name    = azurerm_storage_container.container.name
  start             = time_static.sas_start.rfc3339
  expiry            = time_offset.sas_expiry.rfc3339

  permissions {
    read   = true
    write  = false
    delete = false
    list   = false
    add    = false
    create = false
  }
}