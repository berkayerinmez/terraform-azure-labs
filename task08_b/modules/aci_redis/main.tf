resource "random_password" "redis_password" {
  length           = var.password_config.length
  special          = var.password_config.special
  override_special = var.password_config.override_special
}

resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.rg_name
  ip_address_type     = var.ip_address_ty
  dns_name_label      = var.dns_name_label
  os_type             = var.os_ty
  tags                = var.tags

  container {
    name     = var.container_name
    image    = var.container_image
    cpu      = var.container_config.cpu
    memory   = var.container_config.memory
    commands = ["redis-server", "--protected-mode", "no", "--requirepass", random_password.redis_password.result]

    dynamic "ports" {
      for_each = var.ports
      content {
        port     = ports.value.port
        protocol = ports.value.protocol
      }
    }

    environment_variables = {
      for env in var.environment_variables : env.name => env.value
    }
  }
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_container_group.aci.fqdn
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = var.redis_password_secret_name
  value        = random_password.redis_password.result
  key_vault_id = var.key_vault_id
}