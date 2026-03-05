resource "azurerm_redis_cache" "redis" {
  name                 = var.redis_cache_name
  location             = var.location
  resource_group_name  = var.rg_name
  capacity             = var.capacity
  family               = var.family
  sku_name             = var.sku_name
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
  tags                 = var.tags

  redis_configuration {
  }
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname
  value        = azurerm_redis_cache.redis.hostname
  key_vault_id = var.key_vault_id
  tags         = var.tags
  depends_on   = [azurerm_redis_cache.redis]
}

resource "azurerm_key_vault_secret" "redis_primary_key" {
  name         = var.redis_primary_key
  value        = azurerm_redis_cache.redis.primary_access_key
  key_vault_id = var.key_vault_id
  tags         = var.tags
  depends_on   = [azurerm_redis_cache.redis]
}

