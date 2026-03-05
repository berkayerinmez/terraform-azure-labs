# Task 09 — Azure Firewall with AKS

Deploys Azure Firewall in front of an existing AKS cluster to control and inspect egress/ingress traffic. Implements network, application, and NAT rules with route tables for traffic redirection.

## Architecture

```
Existing Resources (data sources)
├── Resource Group
├── Virtual Network
├── AKS Subnet
└── AKS Cluster

Azure Firewall Module
├── AzureFirewallSubnet (10.0.1.0/26)
├── Public IP (Static, Standard)
├── Azure Firewall (Standard tier)
│   ├── Application Rule Collection
│   │   └── AKS FQDN tag rule
│   ├── Network Rule Collection
│   │   ├── TCP rule (port 9000 → AzureCloud)
│   │   └── UDP rule (port 1194 → AzureCloud)
│   └── NAT Rule Collection
│       └── DNAT: port 80 → AKS LoadBalancer
└── Route Table
    ├── Route: 0.0.0.0/0 → Firewall (VirtualAppliance)
    ├── Route: Firewall Public IP → Internet (direct)
    └── Association → AKS Subnet
```

## Azure Services
| Service | Purpose |
|---|---|
| Azure Firewall | L3–L7 network security and traffic inspection |
| Route Table | Forces traffic through the firewall |
| Public IP | Firewall's public-facing IP |
| AKS (existing) | Kubernetes cluster being protected |

## Terraform Concepts Demonstrated
- **`data` blocks** to reference pre-existing infrastructure (RG, VNet, AKS)
- **Custom module** for firewall with complex variable structures
- **DNAT rules** for inbound traffic translation (Public IP → AKS LB)
- **Application rules** with Azure FQDN tags
- **Network rules** for AKS control plane communication
- **Route tables** to force egress through the firewall
- **Locals** for consistent naming

## Module Structure
```
task09/
├── main.tf, variables.tf, outputs.tf, locals.tf, versions.tf
└── modules/
    └── afw/   # Firewall, Public IP, Subnet, Route Table, Rule Collections
```

## Deploy
```bash
# Prerequisite: An AKS cluster must already exist (task08 or task08_b)
terraform init
terraform plan
terraform apply
```

> ⚠️ **Prerequisite**: This task expects an existing AKS cluster, VNet, and Resource Group. Deploy task08 or task08_b first.
