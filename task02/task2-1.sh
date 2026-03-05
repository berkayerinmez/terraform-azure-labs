#!/bin/bash
#===============================================================================
# VPN Gateway VNet-to-VNet Connection
# Creates two VNets in different regions, deploys VPN Gateways in each,
# and establishes a bidirectional VNet-to-VNet VPN connection between them.
#===============================================================================

# ─── Configuration Variables ─────────────────────────────────────────────────
# Modify these variables to match your environment

SUBSCRIPTION_ID="<YOUR_SUBSCRIPTION_ID>"
TAG="Creator=your_email@example.com"

# Region 1
REGION_1="eastus"
RG_1="cmaz-mod2-rg-01"
VNET_1="cmaz-mod2-vnet-01"
VNET_1_PREFIX="10.2.0.0/16"
SUBNET_1="frontend-01"
SUBNET_1_PREFIX="10.2.0.0/24"
GW_SUBNET_1_PREFIX="10.2.255.0/27"
VPNG_1="cmaz-mod2-vpng-01"
PIP_1="cmaz-mod2-pip-01"
VPN_CONN_1="cmaz-mod2-vcn-01"

# Region 2 (paired region)
REGION_2="westus"
RG_2="cmaz-mod2-rg-02"
VNET_2="cmaz-mod2-vnet-02"
VNET_2_PREFIX="10.24.0.0/16"
SUBNET_2="frontend-02"
SUBNET_2_PREFIX="10.24.0.0/24"
GW_SUBNET_2_PREFIX="10.24.255.0/27"
VPNG_2="cmaz-mod2-vpng-02"
PIP_2="cmaz-mod2-pip-02"
VPN_CONN_2="cmaz-mod2-vcn-02"

# Shared key for VPN connection (change this to a secure value)
SHARED_KEY="<YOUR_SHARED_KEY>"

# ─── Set Subscription ────────────────────────────────────────────────────────
az account set --subscription "$SUBSCRIPTION_ID"

# ─── Region 1: Resource Group, VNet, Subnets, Public IP, VPN Gateway ────────
echo "==> Creating Region 1 resources in $REGION_1..."

az group create -n "$RG_1" -l "$REGION_1"

az network vnet create \
  -n "$VNET_1" \
  -g "$RG_1" \
  -l "$REGION_1" \
  --address-prefix "$VNET_1_PREFIX" \
  --subnet-name "$SUBNET_1" \
  --subnet-prefix "$SUBNET_1_PREFIX"

az network vnet subnet create \
  --vnet-name "$VNET_1" \
  -n GatewaySubnet \
  -g "$RG_1" \
  --address-prefix "$GW_SUBNET_1_PREFIX"

az network public-ip create \
  -g "$RG_1" \
  -n "$PIP_1" \
  --sku Standard \
  --allocation-method Static \
  -l "$REGION_1"

echo "==> Creating VPN Gateway 1 (this can take 20-40 minutes)..."
az network vnet-gateway create \
  --name "$VPNG_1" \
  --public-ip-address "$PIP_1" \
  --resource-group "$RG_1" \
  --vnet "$VNET_1" \
  --gateway-type Vpn \
  --sku VpnGw2 \
  --vpn-gateway-generation Generation2 \
  --no-wait

# ─── Region 2: Resource Group, VNet, Subnets, Public IP, VPN Gateway ────────
echo "==> Creating Region 2 resources in $REGION_2..."

az group create -n "$RG_2" -l "$REGION_2"

az network vnet create \
  -n "$VNET_2" \
  -g "$RG_2" \
  -l "$REGION_2" \
  --address-prefix "$VNET_2_PREFIX" \
  --subnet-name "$SUBNET_2" \
  --subnet-prefix "$SUBNET_2_PREFIX"

az network vnet subnet create \
  --vnet-name "$VNET_2" \
  -n GatewaySubnet \
  -g "$RG_2" \
  --address-prefix "$GW_SUBNET_2_PREFIX"

az network public-ip create \
  -g "$RG_2" \
  -n "$PIP_2" \
  --sku Standard \
  --allocation-method Static \
  -l "$REGION_2"

echo "==> Creating VPN Gateway 2 (this can take 20-40 minutes)..."
az network vnet-gateway create \
  -n "$VPNG_2" \
  -l "$REGION_2" \
  --public-ip-address "$PIP_2" \
  -g "$RG_2" \
  --vnet "$VNET_2" \
  --gateway-type Vpn \
  --sku VpnGw2 \
  --vpn-gateway-generation Generation2

# ─── Wait for Gateway 1 ─────────────────────────────────────────────────────
echo "==> Waiting for VPN Gateway 1 to finish provisioning..."
az network vnet-gateway wait --name "$VPNG_1" -g "$RG_1" --created

# ─── Get Gateway IDs ─────────────────────────────────────────────────────────
VPNG_1_ID=$(az network vnet-gateway show -n "$VPNG_1" -g "$RG_1" --query id -o tsv)
VPNG_2_ID=$(az network vnet-gateway show -n "$VPNG_2" -g "$RG_2" --query id -o tsv)

# ─── Create VPN Connections ──────────────────────────────────────────────────
echo "==> Creating VPN connection: Region 1 -> Region 2..."
az network vpn-connection create \
  -n "$VPN_CONN_1" \
  -g "$RG_1" \
  --vnet-gateway1 "$VPNG_1_ID" \
  -l "$REGION_1" \
  --shared-key "$SHARED_KEY" \
  --vnet-gateway2 "$VPNG_2_ID"

echo "==> Creating VPN connection: Region 2 -> Region 1..."
az network vpn-connection create \
  -n "$VPN_CONN_2" \
  -g "$RG_2" \
  --vnet-gateway1 "$VPNG_2_ID" \
  -l "$REGION_2" \
  --shared-key "$SHARED_KEY" \
  --vnet-gateway2 "$VPNG_1_ID"

# ─── Verify Connections ─────────────────────────────────────────────────────
echo "==> Verifying connections..."
az network vpn-connection show --name "$VPN_CONN_1" --resource-group "$RG_1" -o table
az network vpn-connection show --name "$VPN_CONN_2" --resource-group "$RG_2" -o table

echo "==> Done! Both VPN connections created successfully."
