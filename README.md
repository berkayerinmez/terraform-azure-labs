# ☁️ Terraform Azure Labs

This repository documents a progressive, hands-on learning journey into **Cloud Infrastructure and Automation**. Over the course of a month, I built this series of labs to bridge theoretical knowledge with practical, real-world application, advancing from foundational manual deployments to production-grade Kubernetes orchestration.

> **Overview**: A collection of structured **Infrastructure as Code (IaC)** projects using **Terraform** and **Azure**. These labs demonstrate core competencies in cloud architecture, covering secure networking, multi-region deployments, secret management, and containerization (AKS/ACA).

---

## 🛠️ Tech Stack

| Tool | Version | Purpose |
|---|---|---|
| **Terraform** | >= 1.5.7 | Infrastructure as Code |
| **Azure (AzureRM)** | >= 3.110.0 | Cloud provider |
| **Azure CLI** | latest | CLI-based provisioning (task02) |
| **Docker** | — | Container image builds |
| **Kubernetes** | — | Container orchestration |

---

## 📚 Tasks Overview

The tasks are ordered by complexity — each one builds on concepts from previous tasks.

| Task | Description | Key Azure Services | Key Terraform Concepts |
|---|---|---|---|
| **[task01](./task01/)** | Windows Server & IIS (Manual) | Virtual Machine, RDP, Entra ID (SPN) | *Azure Portal, Remote Desktop, IIS* |
| **[task02](./task02/)** | VPN Gateway & VNet Peering (Azure CLI) | VPN Gateway, VNet Peering, Public IP | Azure CLI scripting, variables |
| **[task03](./task03/)** | Resource Group, Storage & VNet | Resource Group, Storage Account, VNet, Subnets | Resources, variables, `count` |
| **[task04](./task04/)** | Linux VM with Nginx | Virtual Machine, NSG, Public IP | `remote-exec` provisioner, `sensitive` |
| **[task05](./task05/)** | Multi-Region App Services + Traffic Manager | App Service, Traffic Manager | Modules, `for_each`, complex types |
| **[task06](./task06/)** | SQL Server + Key Vault + Web App | SQL Database, Key Vault, App Service | `data` blocks, modules, secrets |
| **[task07](./task07/)** | VM Backup & Recovery | Recovery Services Vault, VM, Storage | Provisioners, recovery config |
| **[task08](./task08/)** | AKS + ACR + Redis + ACI | AKS, ACR, Redis, ACI, Key Vault | `kubectl_manifest`, `templatefile()`, CSI |
| **[task08_b](./task08_b/)** | AKS + ACA + Blob Storage (Advanced) | AKS, ACA, ACR, Blob Storage | Container Apps, SAS tokens, 7 modules |
| **[task09](./task09/)** | Azure Firewall for AKS | Azure Firewall, Route Table | DNAT rules, FQDN tags, route tables |

---

## 🚀 Getting Started

### Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.7
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed and authenticated
- An active Azure subscription

### Usage
```bash
# 1. Clone the repository
git clone https://github.com/berkayerinmez/terraform-azure-labs.git
cd terraform-azure-labs

# 2. Navigate to a task
cd task03

# 3. Update terraform.tfvars with your values
#    (replace placeholder values like <YOUR_SUBSCRIPTION_ID>)

# 4. Deploy
terraform init
terraform plan
terraform apply

# 5. Clean up when done
terraform destroy
```

### Sensitive Variables
Some tasks require sensitive values (passwords, PATs). Pass them via environment variables:
```bash
export TF_VAR_vm_password="YourSecurePassword123!"
export TF_VAR_admin_password="YourSecurePassword123!"
export TF_VAR_git_pat="<YOUR_GITHUB_PAT>"
```

---

## 📂 Repository Structure

```
.
├── README.md
├── task01/          # Manual portal setup: Windows VM, IIS, SPN (Documentation only)
├── task02/          # Azure CLI: VPN Gateway & VNet Peering
├── task03/          # Terraform: Resource Group, Storage, VNet
├── task04/          # Terraform: Linux VM with Nginx
├── task05/          # Terraform: App Services + Traffic Manager (modules)
├── task06/          # Terraform: SQL + Key Vault + Web App (modules)
├── task07/          # Terraform: VM Backup & Recovery
├── task08/          # Terraform: AKS, ACR, Redis, ACI (modules + K8s)
├── task08_b/        # Terraform: AKS, ACA, Blob Storage (advanced modules)
└── task09/          # Terraform: Azure Firewall for AKS (modules)
```

---

## 🧭 Learning Progression

```
Cloud Portal Basics & Windows RDP (task01)
    ↓
Azure CLI Basics (task02)
    ↓
Terraform Fundamentals — resources, variables, count (task03)
    ↓
Compute & Networking — VMs, NSGs, provisioners (task04)
    ↓
Modules & Multi-Region — for_each, modules, Traffic Manager (task05)
    ↓
Data & Secrets — SQL, Key Vault, data blocks (task06)
    ↓
Backup & Recovery — Recovery Services Vault (task07)
    ↓
Containers & Kubernetes — AKS, ACR, ACI, K8s manifests (task08)
    ↓
Advanced Containers — ACA, Blob Storage, SAS tokens (task08_b)
    ↓
Network Security — Azure Firewall, DNAT, route tables (task09)
```

---

## 📝 Notes

- **Task 01**: This folder contains no infrastructure code; it instead holds the documentation for the foundational exercise completed manually via the Azure Portal (provisioning a Windows Server VM, configuring IIS, and setting up an Entra ID Service Principal/App Registration).
- All `terraform.tfvars` files contain **placeholder values** — update them with your own Azure subscription details before deploying.
- Each task folder has its own `README.md` with detailed architecture diagrams and explanations.
- Tasks are independent but some build on each other (e.g., task09 requires an existing AKS cluster from task08 or something similar).
