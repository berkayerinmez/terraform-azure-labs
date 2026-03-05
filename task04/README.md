# Task 04 — Linux Virtual Machine with Nginx

Provisions a Linux VM on Azure, configures networking (NSG, Public IP), and uses a **Terraform provisioner** to automatically install and start Nginx.

## Architecture

```
Resource Group
├── Virtual Network (10.0.0.0/16)
│   └── Subnet: frontend (10.0.0.0/24)
├── Network Security Group
│   ├── Rule: AllowSSH (port 22)
│   └── Rule: AllowHTTP (port 80)
├── Public IP (Static, Standard)
├── Network Interface
│   └── NSG Association
└── Linux VM (Ubuntu 24.04 LTS)
    └── Provisioner: remote-exec → installs Nginx
```

## Azure Services
| Service | Purpose |
|---|---|
| Linux Virtual Machine | Ubuntu server running Nginx |
| Network Security Group | Firewall rules for SSH & HTTP |
| Public IP | Static IP with DNS label |
| Virtual Network + Subnet | Network isolation |

## Terraform Concepts Demonstrated
- **`remote-exec` provisioner** for post-deployment configuration
- **SSH connection block** for provisioner authentication
- **NSG rules** as separate resources (not inline)
- **`depends_on`** for explicit dependency ordering
- **`sensitive = true`** for password variables

## Deploy
```bash
# Set your values in terraform.tfvars (including vm_password via env var or prompt)
export TF_VAR_vm_password="YourSecurePassword123!"
terraform init
terraform plan
terraform apply
```

> After deployment, access Nginx at: `http://<dns_name_label>.<region>.cloudapp.azure.com`
