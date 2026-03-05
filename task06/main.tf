resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

data "azurerm_client_config" "clt" {}

data "azurerm_key_vault" "kv" {
  name                = var.kv_name
  resource_group_name = var.kv_rg_name
}



module "sql" {
  source                   = "./modules/sql"
  rg_location              = azurerm_resource_group.rg.location
  rg_name                  = azurerm_resource_group.rg.name
  sql_sv_name              = local.sql_server_name
  sql_db_name              = local.sql_db_name
  admin_username           = var.sql_module.admin_username
  fw_rule_name             = var.sql_module.fw_rule_name
  kv_rg_name               = var.kv_rg_name
  kv_name                  = var.kv_name
  kv_secret_admin_name     = var.sql_module.kv_secret_admin_name
  kv_secret_admin_password = var.sql_module.kv_secret_admin_password
  allowed_ip_address       = var.allowed_ip_address
  kv_id                    = data.azurerm_key_vault.kv.id
  tags                     = var.tags


}

module "webapp" {
  source                = "./modules/webapp"
  rg_name               = azurerm_resource_group.rg.name
  rg_location           = azurerm_resource_group.rg.location
  sp_name               = local.asp_name
  os_type               = var.webapp_module.os_type
  web_app_name          = local.app_name
  dotnet_version        = var.webapp_module.dotnet_version
  sku_name              = var.webapp_module.sku_name
  sql_connection_string = module.sql.sql_connection_string
  tags                  = var.tags
}
