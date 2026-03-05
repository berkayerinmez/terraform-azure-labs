resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = var.sku
  admin_enabled       = var.admin_enabled
  tags                = var.tags
}

resource "azurerm_container_registry_task" "acr_task" {
  name                  = var.acr_task_name
  container_registry_id = azurerm_container_registry.acr.id
  tags                  = var.tags

  identity {
    type = "SystemAssigned"
  }

  platform {
    os           = var.platform_config.os
    architecture = var.platform_config.architecture
  }

  docker_step {
    context_path         = var.blob_url
    context_access_token = var.sas_token
    dockerfile_path      = var.dockerfile_path
    image_names          = ["${var.app_image_name}:${var.image_tag}"]
    push_enabled         = var.push_enabled
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "acr_schedule" {
  container_registry_task_id = azurerm_container_registry_task.acr_task.id
}