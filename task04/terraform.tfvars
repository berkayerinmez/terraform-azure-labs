// This file overrides default variable values.
// Terraform reads terraform.tfvars automatically.
// For other .tfvars files, specify them with: terraform plan -var-file="filename.tfvars"

resource_group_name = "cmaz-mod4-rg"
location            = "westus3"

virtual_network_name   = "cmaz-mod4-vnet"
subnet_name            = "frontend"
network_interface_name = "cmaz-mod4-nic"
nsg_name               = "cmaz-mod4-nsg"
nsg_inbound_http_rule  = "AllowHTTP"
nsg_inbound_ssh_rule   = "AllowSSH"
public_ip_name         = "cmaz-mod4-pip"
dns_name_label         = "cmaz-mod4-nginx"
vm_name                = "cmaz-mod4-vm"
vm_os_version          = "ubuntu-24_04-lts"
vm_sku                 = "Standard_B2s_v2"

nic_ip_configuration_name = "internal"

vm_username = "azureuser"

subscription_id = "<YOUR_SUBSCRIPTION_ID>"

tags = { Creator = "your_email@example.com" }
