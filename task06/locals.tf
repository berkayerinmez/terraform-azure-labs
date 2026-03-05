locals {
  rg_name         = join("-", [var.resource_name_prefix, var.rg_name])
  sql_server_name = join("-", [var.resource_name_prefix, var.sql_module.sql_sv_name])
  sql_db_name     = join("-", [var.resource_name_prefix, var.sql_module.sql_db_name])
  asp_name        = join("-", [var.resource_name_prefix, var.webapp_module.sp_name])
  app_name        = join("-", [var.resource_name_prefix, var.webapp_module.web_app_name])
}