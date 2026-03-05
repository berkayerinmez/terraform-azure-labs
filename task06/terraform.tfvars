location       = "westus2"
rg_name        = "rg"
kv_secret_name = "sql-server-task06"
kv_rg_name     = "cmaz-mod6-kv-rg"
kv_name        = "cmaz-mod6-kv"
kv_sku_name    = "standard"

sql_module = {
  sql_sv_name              = "sql"
  sql_db_name              = "sql-db"
  admin_username           = "sqltestuser"
  fw_rule_name             = "allow-verification-ip"
  kv_secret_admin_name     = "sql-admin-name"
  kv_secret_admin_password = "sql-admin-password"
}
allowed_ip_address = "<YOUR_IP_ADDRESS>"
webapp_module = {
  sp_name        = "asp"
  os_type        = "Linux"
  web_app_name   = "app"
  dotnet_version = "8.0"
  sku_name       = "P0v3"
}
resource_name_prefix = "cmaz-mod6"
tags                 = { Creator = "your_email@example.com" }
