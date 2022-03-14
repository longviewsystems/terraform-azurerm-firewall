# TF networking 
resource_group_name   = "lic-networking-rg"
location              = "canadacentral"

#vnet
vnet_name       = "lic-networking-vnet"
address_spaces  = ["10.0.0.0/16"]

# subnet
subnet_name     = "AzureFirewallSubnet"
subnet_prefixes = ["10.0.1.0/24"]


# public ip
public_ip_name   = "lic-public-ip"

# firewall
firewall_name     = "lic-firewall"

tags = {
  environment = "test",
  managedBy   = "Terraform"
}
