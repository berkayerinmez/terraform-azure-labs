# General
location    = "eastus"
name_prefix = "cmtr-mod8b"

tags = {
  Creator = "your_email@example.com"
}

# Key Vault
kv_sku_name = "standard"

# Storage Account
account_replication_ty = "LRS"
storage_container_name = "app-content"
container_access_ty    = "private"

# ACI Redis
aci_dns_name_label  = "cmtr-mod8b-redis-ci"
aci_container_name  = "redis"
aci_container_image = "mcr.microsoft.com/cbl-mariner/base/redis:6"

redis_hostname_secret_name = "redis-hostname"
redis_password_secret_name = "redis-password"

# ACR
acr_sku        = "Basic"
acr_task_name  = "cmtr-mod8b-acr-task"
app_image_name = "cmtr-mod8b-app"

# AKS
aks_node_pool_name  = "system"
aks_node_count      = 1
aks_vm_size         = "Standard_D2ads_v6"
aks_os_disk_ty      = "Ephemeral"
aks_os_disk_size_gb = 75

# ACA
aca_identity_name = "cmtr-mod8b-ca-identity"

workload_profiles = [
  {
    name          = "Consumption"
    tip           = "Consumption"
    minimum_count = null
    maximum_count = null
  }
]

secret_redis_url_name = "redis-url"
secret_redis_key_name = "redis-key"

aca_env_vars = [
  { name = "CREATOR", value = "ACA", secret_name = null },
  { name = "REDIS_PORT", value = "6379", secret_name = null },
  { name = "REDIS_URL", value = null, secret_name = "redis-url" },
  { name = "REDIS_PWD", value = null, secret_name = "redis-key" }
]
