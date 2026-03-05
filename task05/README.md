# Task 05 — Multi-Region App Services with Traffic Manager

Deploys Azure App Services across multiple regions with Azure Traffic Manager for performance-based routing. Uses **Terraform modules** for reusable, DRY infrastructure code.

## Architecture

```
Resource Group 1 (East US)          Resource Group 2 (West US)
├── App Service Plan (S1, 2 workers) ├── App Service Plan (S1, 1 worker)
└── App Service (with IP restrictions)└── App Service (with IP restrictions)

Resource Group 3 (Central US)
└── Traffic Manager Profile (Performance routing)
    ├── Endpoint → App Service 1
    └── Endpoint → App Service 2
```

## Azure Services
| Service | Purpose |
|---|---|
| App Service Plans | Hosting plans with configurable SKU and workers |
| App Services | Web applications with IP-based access restrictions |
| Traffic Manager | DNS-based load balancing with Performance routing |
| Resource Groups | Regional grouping of resources |

## Terraform Concepts Demonstrated
- **Custom modules** (`modules/resource_group`, `modules/app_service_plan`, `modules/app_service`, `modules/traffic_manager`)
- **`for_each`** with maps for dynamic resource creation
- **Cross-module references** (e.g., App Service → App Service Plan ID)
- **Complex variable types** (maps of objects, lists of objects)
- **IP restrictions** with service tags (`AzureTrafficManager`)
- **`depends_on`** for module ordering

## Module Structure
```
task05/
├── main.tf              # Module calls
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── terraform.tfvars     # Variable values
├── versions.tf          # Provider configuration
└── modules/
    ├── resource_group/
    ├── app_service_plan/
    ├── app_service/
    └── traffic_manager/
```

## Deploy
```bash
terraform init
terraform plan
terraform apply
```
