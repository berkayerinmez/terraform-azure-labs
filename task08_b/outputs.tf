output "redis_fqdn" {
  value       = module.aci_redis.redis_fqdn
  description = "FQDN of Redis in Azure Container Instance"
}

output "aca_fqdn" {
  value       = module.aca.aca_fqdn
  description = "FQDN of the application in Azure Container App"
}

output "aks_lb_ip" {
  value       = module.k8s.aks_lb_ip
  description = "Load Balancer IP address of the application in AKS"
}