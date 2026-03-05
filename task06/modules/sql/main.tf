// /modules/sql/main.tf
/// Generate a random password if not provided
resource "random_password" "admin_password" {
  length      = 20
  special     = true
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
}

locals {
  admin_password = random_password.admin_password.result
}

/// Key Vault to store the SQL Admin Password


resource "azurerm_key_vault_secret" "sql_admin_name" {
  name         = var.kv_secret_admin_name
  key_vault_id = var.kv_id
  value        = var.admin_username
  tags         = var.tags
}

resource "azurerm_key_vault_secret" "sql_admin_password" {
  name         = var.kv_secret_admin_password
  key_vault_id = var.kv_id
  value        = local.admin_password
  tags         = var.tags
}

/// SQL Server and Database

resource "azurerm_mssql_server" "server" {
  name                         = var.sql_sv_name
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  administrator_login          = var.admin_username
  administrator_login_password = local.admin_password
  version                      = "12.0"
  tags                         = var.tags
}

resource "azurerm_mssql_database" "db" {
  name      = var.sql_db_name
  server_id = azurerm_mssql_server.server.id
  sku_name  = "S2"
  tags      = var.tags
}

/// Firewall Rule: Allow Azure Services
resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "AllowAzureServices"
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

/// Firewall Rule: Allow Verification IP
resource "azurerm_mssql_firewall_rule" "allow_verification_ip" {
  name             = var.fw_rule_name
  server_id        = azurerm_mssql_server.server.id
  start_ip_address = var.allowed_ip_address
  end_ip_address   = var.allowed_ip_address
}