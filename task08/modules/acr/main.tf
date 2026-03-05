resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku
  admin_enabled       = true

  tags = var.tags
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = var.acr_task_name
  container_registry_id = azurerm_container_registry.acr.id
  platform {
    os = var.os
  }
  docker_step {
    context_access_token = var.ctx_acs_token
    context_path         = var.docker_ctx_path
    dockerfile_path      = var.docker_file_path
    image_names          = ["${var.app_image_name}:latest"]

  }
  tags = var.tags
}

resource "azurerm_container_registry_task_schedule_run_now" "acr_schedule" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}