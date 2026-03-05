# Task 08_b — AKS, Azure Container Apps & Blob Storage (Advanced)

An advanced variant of Task 08 that adds **Azure Container Apps (ACA)** and **Blob Storage** with SAS token-based ACR builds. Demonstrates running the same app on both AKS and ACA with Key Vault-backed secrets.

## Architecture

```
Resource Group
├── Key Vault
│   ├── Secret: redis-hostname
│   └── Secret: redis-password
├── Storage Account
│   └── Blob Container (app-content) → SAS token
├── ACR (Azure Container Registry)
│   └── ACR Task → builds from Blob Storage
├── ACI Redis (containerized Redis)
├── AKS (Azure Kubernetes Service)
│   ├── System node pool (Ephemeral OS disk)
│   └── K8s Module (SecretProviderClass, Deployment, Service)
└── ACA (Azure Container Apps)
    ├── ACA Environment (Consumption workload)
    ├── User Assigned Identity → Key Vault access
    └── Container App (with KV secret references)
```

## Azure Services
| Service | Purpose |
|---|---|
| AKS | Managed Kubernetes cluster |
| ACA | Serverless container platform (alternative to AKS) |
| ACR | Container registry with build from Blob Storage |
| ACI | Redis container instance |
| Key Vault | Centralized secret management |
| Blob Storage | Application source code hosting |

## Terraform Concepts Demonstrated
- **7 custom modules** (keyvault, storage, aci_redis, acr, aks, aca, k8s)
- **Azure Container Apps** with Key Vault secret references
- **Blob Storage + SAS token** for ACR Task build context
- **Ephemeral OS disks** for AKS nodes (cost optimization)
- **Workload profiles** for ACA environment
- **User Assigned Identity** for ACA → Key Vault access
- **Complex variable structures** (lists of objects for secrets, env vars)

## Project Structure
```
task08_b/
├── main.tf, variables.tf, outputs.tf, locals.tf, versions.tf
├── application/
│   ├── app.py, Dockerfile, requirements.txt
├── k8s-manifests/
│   ├── deployment.yaml.tftpl
│   ├── secret-provider.yaml.tftpl
│   └── service.yaml
└── modules/
    ├── aca/        # Container Apps + Environment + Identity
    ├── aci_redis/  # Redis on ACI + KV secrets
    ├── acr/        # Container Registry + ACR Task from Blob
    ├── aks/        # Kubernetes Service
    ├── k8s/        # K8s manifests (kubectl_manifest)
    ├── keyvault/   # Key Vault
    └── storage/    # Storage Account + Blob + SAS token
```

## Deploy
```bash
terraform init
terraform plan
terraform apply
```
