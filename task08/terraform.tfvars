name_prefix = "cmtr-mod8"
location    = "eastus"

tags = {
  Creator = "your_email@example.com"
}

resource_group_name = "cmtr-mod8-rg"


kv_sku_name = "standard"


acr_name         = "cmtrmod8cr"
acr_sku          = "Basic"
acr_task_name    = "cmtr-mod8-acr-task"
docker_ctx_path  = "https://github.com/<YOUR_USERNAME>/<YOUR_REPO>.git#main:task08/application"
docker_file_path = "Dockerfile"
acr_os           = "Linux"

redis_cache_name = "cmtr-mod8-redis"
redis_capacity   = 2

aci_name            = "cmtr-mod8-ci"
aci_dns_name_label  = "cmtr-mod8-ci"
aci_container_name  = "cmtr-mod8-app"
aci_container_image = "cmtrmod8cr.azurecr.io/cmtr-mod8-app:latest"
aci_cpu             = 1
aci_memory          = 1.5
aci_port            = 8080

aks_name               = "cmtr-mod8-aks"
aks_dns_prefix         = "cmtr-mod8-aks"
aks_node_pool_name     = "system"
aks_node_count         = 1
aks_vm_size            = "Standard_D2ads_v6"
aks_user_identity_name = "cmtr-mod8-aks-uai"
aks_role_def_name      = "AcrPull"

app_image_name = "cmtr-mod8-app"
image_tag      = "latest"
