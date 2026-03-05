// This file overrides default variable values.
// Terraform reads terraform.tfvars automatically.
// For other .tfvars files, specify them with: terraform plan -var-file="filename.tfvars"

resource_group_name = "cmaz-mod3-rg"
location            = "East US"

storageaccount_name  = "cmazmod3sa"
virtual_network_name = "cmaz-mod3-vnet"

subnet_names = ["frontend", "backend"]

subscription_id = "<YOUR_SUBSCRIPTION_ID>"

tags = {
  Creator = "your_email@example.com"
}
