// modules/webapp/main.tf
resource "azurerm_service_plan" "service_plan" {
  name                = var.sp_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  os_type             = var.os_type
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "linux_web_app" {
  name                = var.web_app_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  service_plan_id     = azurerm_service_plan.service_plan.id

  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }

  app_settings = {
    "ConnectionStrings__DefaultConnection" = var.sql_connection_string
  }

  connection_string {
    name  = var.connection_string_name
    type  = "SQLAzure"
    value = var.sql_connection_string
  }

  tags = var.tags
}