// module/sql/outputs.tf
output "sql_server_id" {
  description = "SQL Server ID"
  value       = azurerm_mssql_server.server.id
}

output "sql_server_fqdn" {
  description = "SQL Server fully qualified domain name"
  value       = azurerm_mssql_server.server.fully_qualified_domain_name
}

output "sql_database_id" {
  description = "SQL Database ID"
  value       = azurerm_mssql_database.db.id
}

output "sql_connection_string" {
  description = "SQL Database connection string for ADO.NET"
  value       = "Server=tcp:${azurerm_mssql_server.server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.db.name};Persist Security Info=False;User ID=${var.admin_username};Password=${local.admin_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  sensitive   = true
}
