module "networking" {
  source = "./resources"
}

module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"
  suffix  = ["networking"]
  prefix  = ["lic"]

  unique-include-numbers = false
  unique-length          = 4
}


module "firewall" {
  source              = "../../" # testing root module
  firewall_name       = module.naming.firewall.name_unique
  firewall_pip_name   = module.naming.public_ip.name_unique
  firewall_subnet_id  = module.networking.firewall_subnet_id
  location            = module.networking.virtual_network_resource_group_location
  public_ip_sku       = "Standard"
  availability_zone   = "No-Zone"
  resource_group_name = module.networking.virtual_network_resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  firewall_policy_id  = module.networking.firewall_policy_id


  network_rule_collections = [
    {
      name     = "RuleCollection1"
      priority = 100
      action   = "Allow"
      rules = [
        {
          name                  = "AllowRule1"
          source_addresses      = ["10.10.1.0/24"]
          destination_ports     = ["22"]
          destination_addresses = ["10.10.2.0/24"]
          protocols             = ["TCP"]
          destination_fqdns     = null
          destination_ip_groups = null
          source_ip_groups      = null
        },
        {
          name                  = "AllowRule2"
          source_addresses      = ["10.10.1.0/24"]
          destination_ports     = ["3389"]
          destination_addresses = ["10.10.2.0/24"]
          protocols             = ["TCP"]
          destination_fqdns     = null
          destination_ip_groups = null
          source_ip_groups      = null
        }
      ]
    }
  ]


  application_rule_collections = [
    {
      name     = "AppRuleCollection1"
      priority = 101
      action   = "Allow"
      rules = [
        {
          name             = "AllowGoogle"
          source_addresses = ["10.10.1.0/24", "10.10.2.0/24"]
          target_fqdns     = ["*.google.com", "*.google.fr"]
          source_ip_groups = null
          protocols = [
            {
              port = "443"
              type = "Https"
            },
            {
              port = "80"
              type = "Http"
            }
          ]
        }
      ]
    }
  ]

  nat_rule_collections = [
    {
      name     = "NatRuleCollection1"
      priority = 100
      action   = "Dnat"
      rules = [
        {
          name               = "RedirectWeb"
          source_addresses   = ["10.0.0.0/16"]
          destination_ports  = ["80"]
          translated_port    = 53
          translated_address = "8.8.8.8"
          protocols          = ["TCP", "UDP"]
          source_ip_groups   = null
        }
      ]
    }
  ]
}