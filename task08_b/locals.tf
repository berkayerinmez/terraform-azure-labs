locals {
  name_prefix    = var.name_prefix
  aca_name       = join("-", [var.name_prefix, "ca"])
  aca_env_name   = join("-", [var.name_prefix, "cae"])
  acr_name       = join("", [replace(var.name_prefix, "-", ""), "cr"])
  aks_name       = join("-", [var.name_prefix, "aks"])
  keyvault_name  = join("-", [var.name_prefix, "kv"])
  redis_aci_name = join("-", [var.name_prefix, "redis-ci"])
  rg_name        = join("-", [var.name_prefix, "rg"])
  sa_name        = join("", [replace(var.name_prefix, "-", ""), "sa"])
}