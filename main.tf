module "naming" {
  source  = "Azure/naming/azurerm"
  suffix = [ "networking" ]
  prefix = [ "lic" ]
  
  unique-include-numbers = false
  unique-length          = 4
}


resource "azurerm_public_ip" "firewall_pip" {
  name                = module.naming.public_ip.name_unique
  location            = var.virtual_network.location
  resource_group_name = var.virtual_network.resource_group_name
  allocation_method   = "Static"
  sku                 = var.public_ip_sku
}

resource "azurerm_firewall" "firewall" {
  name                = module.naming.firewall.name_unique
  location            = var.virtual_network.location
  resource_group_name = var.virtual_network.resource_group_name
  ip_configuration {
    name                 = module.naming.firewall_ip_configuration.name
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}