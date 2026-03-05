# Task 08 — AKS, ACR, Redis Cache & ACI

Full containerized application deployment on Azure. Builds a Docker image via ACR Tasks, deploys Redis Cache, runs the app on both ACI and AKS with Kubernetes manifests and CSI secret store integration.

## Architecture

```
Resource Group
├── Key Vault
│   ├── Secret: redis-hostname
│   └── Secret: redis-primary-key
├── ACR (Azure Container Registry)
│   └── ACR Task → builds Docker image from GitHub
├── Redis Cache
├── ACI (Azure Container Instances)
│   └── Flask app container (from ACR)
├── AKS (Azure Kubernetes Service)
│   ├── System node pool
│   ├── User Assigned Identity → AcrPull role
│   └── K8s Resources:
│       ├── SecretProviderClass (CSI → Key Vault)
│       ├── Deployment (Flask app)
│       └── Service (LoadBalancer)
```

## Azure Services
| Service | Purpose |
|---|---|
| AKS | Managed Kubernetes cluster |
| ACR | Container image registry + build tasks |
| Redis Cache | In-memory data store |
| ACI | Serverless container runtime |
| Key Vault | Secret management for Redis credentials |

## Terraform Concepts Demonstrated
- **5 custom modules** (keyvault, acr, aks, redis, aci)
- **`kubectl_manifest`** resource for K8s deployment from Terraform
- **`templatefile()`** for parameterized K8s YAML
- **CSI Secret Store** for Key Vault → K8s secret integration
- **ACR Tasks** for building Docker images from Git context
- **`wait_for`** blocks to wait for K8s resource readiness
- **Cross-module dependency chain** (ACR → ACI, Key Vault → AKS → K8s)

## Application
A Python Flask app (`application/`) that connects to Redis and displays visit counts.

## Project Structure
```
task08/
├── main.tf, variables.tf, outputs.tf, locals.tf, versions.tf
├── application/
│   ├── app.py              # Flask application
│   ├── Dockerfile
│   └── requirements.txt
├── k8s-manifests/
│   ├── deployment.yaml.tftpl      # Templated K8s Deployment
│   ├── secret-provider.yaml.tftpl # CSI SecretProviderClass
│   └── service.yaml               # LoadBalancer Service
└── modules/
    ├── acr/       # Container Registry + ACR Task
    ├── aci/       # Container Instance
    ├── aks/       # Kubernetes Service + Identity
    ├── keyvault/  # Key Vault
    └── redis/     # Redis Cache + KV secrets
```

## Deploy
```bash
# Set git_pat for ACR Task to pull from GitHub (if using private repo)
export TF_VAR_git_pat="<YOUR_GITHUB_PAT>"
terraform init
terraform plan
terraform apply
```
