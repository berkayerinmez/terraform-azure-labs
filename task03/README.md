# Task 03 — Resource Group, Storage Account & Virtual Network

The foundational Terraform task — provisions core Azure infrastructure components that most cloud architectures depend on.

## Architecture

```
Resource Group
├── Storage Account (Standard LRS)
├── Virtual Network (10.0.0.0/16)
│   ├── Subnet: frontend (10.0.0.0/24)
│   └── Subnet: backend  (10.0.1.0/24)
```

## Azure Services
| Service | Purpose |
|---|---|
| Resource Group | Logical container for related resources |
| Storage Account | Blob, file, queue, and table storage |
| Virtual Network | Isolated network with address space |
| Subnets | Network segmentation via `count` |

## Terraform Concepts Demonstrated
- **Resource blocks** for each Azure resource
- **Variable references** with `var.*`
- **`count` meta-argument** to create multiple subnets dynamically
- **Resource references** to link resources (e.g., subnet → VNet)
- **Tags** for resource organization

## Deploy
```bash
# Set your values in terraform.tfvars, then:
terraform init
terraform plan
terraform apply
```
