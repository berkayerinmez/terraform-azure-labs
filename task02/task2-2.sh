#!/bin/bash
#===============================================================================
# VNet Peering
# Creates two VNets and establishes bidirectional VNet peering between them.
# VNet peering enables resources in both VNets to communicate with each other.
#===============================================================================

# ─── Configuration Variables ─────────────────────────────────────────────────
# Modify these variables to match your environment

RESOURCE_GROUP="<YOUR_RESOURCE_GROUP>"
VNET_1="cloudmentor-vnet-1"
VNET_2="cloudmentor-vnet-2"
REGION_1="eastus"
REGION_2="centralus"

# ─── Create VNets ────────────────────────────────────────────────────────────
echo "==> Creating VNet 1 in $REGION_1..."
az network vnet create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_1" \
  --location "$REGION_1"

echo "==> Creating VNet 2 in $REGION_2..."
az network vnet create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_2" \
  --location "$REGION_2"

# ─── Get VNet IDs ────────────────────────────────────────────────────────────
VNET_1_ID=$(az network vnet show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_1" \
  --query id --out tsv)

VNET_2_ID=$(az network vnet show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_2" \
  --query id --out tsv)

# ─── Create Bidirectional Peering ────────────────────────────────────────────
echo "==> Creating peering: $VNET_1 -> $VNET_2..."
az network vnet peering create \
  --name vnet-1-to-vnet-2 \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_1" \
  --remote-vnet "$VNET_2_ID" \
  --allow-vnet-access

echo "==> Creating peering: $VNET_2 -> $VNET_1..."
az network vnet peering create \
  --name vnet-2-to-vnet-1 \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_2" \
  --remote-vnet "$VNET_1_ID" \
  --allow-vnet-access

# ─── Verify Peering ─────────────────────────────────────────────────────────
echo "==> Verifying peering state..."
az network vnet peering show \
  --name vnet-1-to-vnet-2 \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_1" \
  --query peeringState
