resource "azurerm_user_assigned_identity" "user_assigned_identity" {
  location            = var.location
  name                = var.user_assigned_identity_name
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "kv_policy" {
  key_vault_id = var.kv_id
  tenant_id    = azurerm_user_assigned_identity.user_assigned_identity.tenant_id
  object_id    = azurerm_user_assigned_identity.user_assigned_identity.principal_id

  secret_permissions = ["Get"]
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = var.acr_role_definition_name
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
}

resource "azurerm_container_app_environment" "aca_environment" {
  name                = var.aca_environment_name
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags

  dynamic "workload_profile" {
    for_each = var.workload_profiles
    content {
      name                  = workload_profile.value.name
      workload_profile_type = workload_profile.value.tip
      minimum_count         = lookup(workload_profile.value, "minimum_count", null)
      maximum_count         = lookup(workload_profile.value, "maximum_count", null)
    }
  }
}

resource "azurerm_container_app" "aca" {
  name                         = var.aca_name
  container_app_environment_id = azurerm_container_app_environment.aca_environment.id
  resource_group_name          = var.rg_name
  revision_mode                = var.revision_mode
  tags                         = var.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_assigned_identity.id]
  }

  registry {
    server   = var.acr_login_server
    identity = azurerm_user_assigned_identity.user_assigned_identity.id
  }

  dynamic "secret" {
    for_each = var.secrets
    content {
      name                = secret.value.name
      key_vault_secret_id = secret.value.key_vault_secret_id
      identity            = azurerm_user_assigned_identity.user_assigned_identity.id
    }
  }

  template {
    min_replicas = var.container_config.min_replicas
    max_replicas = var.container_config.max_replicas

    container {
      name   = var.container_config.name
      image  = "${var.acr_login_server}/${var.app_image_name}:${var.image_tag}"
      cpu    = var.container_config.cpu
      memory = var.container_config.memory

      dynamic "env" {
        for_each = var.env_vars
        content {
          name        = env.value.name
          value       = lookup(env.value, "value", null)
          secret_name = lookup(env.value, "secret_name", null)
        }
      }
    }
  }

  ingress {
    external_enabled = var.ingress_config.external_enabled
    target_port      = var.ingress_config.target_port

    traffic_weight {
      percentage      = var.ingress_config.traffic_percentage
      latest_revision = true
    }
  }

  depends_on = [
    azurerm_key_vault_access_policy.kv_policy,
    azurerm_role_assignment.acr_pull
  ]
}



