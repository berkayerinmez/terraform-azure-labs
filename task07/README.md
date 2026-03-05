# Task 07 — Virtual Machine with Backup & Recovery

Provisions a Linux VM with Azure Recovery Services Vault for backup and disaster recovery. Demonstrates infrastructure protection and data persistence patterns.

## Architecture

```
Resource Group
├── Recovery Services Vault (Standard)
├── Virtual Network (10.0.0.0/16)
│   └── Subnet (10.0.2.0/24)
├── Network Interface
├── Public IP (Static, Standard)
├── Storage Account (Standard LRS, private)
└── Linux VM (Ubuntu 24.04 LTS)
    └── Provisioner: creates a test file
```

## Azure Services
| Service | Purpose |
|---|---|
| Recovery Services Vault | Backup policies and restore points |
| Linux Virtual Machine | Protected workload |
| Storage Account | Private storage (no public access) |
| Virtual Network + Subnet | Network isolation |
| Public IP | Static IP with DNS label |

## Terraform Concepts Demonstrated
- **Recovery Services Vault** configuration with soft delete disabled (for dev/test)
- **`remote-exec` provisioner** for post-deployment file creation
- **Private storage** with `public_network_access_enabled = false`
- **`sensitive = true`** for admin password variable
- **Resource dependencies** via implicit and explicit references

## Deploy
```bash
export TF_VAR_admin_password="YourSecurePassword123!"
terraform init
terraform plan
terraform apply
```

> 💡 **Note**: The Recovery Services Vault has `soft_delete_enabled = false` for easier cleanup in dev/test environments. Enable it in production.
