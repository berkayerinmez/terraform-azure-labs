# Task 02 — Azure CLI: VPN Gateway & VNet Peering

This task demonstrates Azure networking fundamentals using **Azure CLI** (not Terraform), covering two core connectivity patterns:

## What's Inside

### `task2-1.sh` — VNet-to-VNet VPN Gateway Connection
Creates a site-to-site VPN connection between two VNets in different Azure regions using VPN Gateways.

**Resources Created:**
- 2× Resource Groups (one per region)
- 2× Virtual Networks with frontend subnets
- 2× Gateway Subnets
- 2× Public IP addresses (Standard SKU)
- 2× VPN Gateways (VpnGw2, Generation2)
- 2× Bidirectional VPN connections

### `task2-2.sh` — VNet Peering
Creates two VNets and establishes bidirectional VNet peering — a simpler, lower-latency alternative to VPN Gateways for connecting VNets within Azure.

**Resources Created:**
- 2× Virtual Networks
- 2× VNet Peering connections (bidirectional)

## Key Concepts
- **VPN Gateway vs VNet Peering**: VPN Gateways support cross-premises and encrypted connections but have higher latency and cost. VNet Peering is faster and cheaper but only works within Azure.
- **Gateway Subnet**: A special subnet required for VPN Gateway deployment, named `GatewaySubnet`.
- **Shared Key**: Both VPN connections must use the same shared key to establish the tunnel.
- **Paired Regions**: Using Azure paired regions for disaster recovery and data residency compliance.

## Setup
1. Update the variables at the top of each script with your own values
2. Login to Azure: `az login`
3. Run the script: `bash task2-1.sh` or `bash task2-2.sh`

> ⚠️ **Note**: VPN Gateway provisioning can take 20–40 minutes. The script uses `--no-wait` for gateway creation — verify provisioning status before creating connections.
