module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.1.1"
  suffix  = ["networking"]
  prefix  = ["lic"]

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
    name                 = module.naming.firewall_ip_configuration.name_unique
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

# Add firewall network rule collection
resource "azurerm_firewall_network_rule_collection" "network_rule_collection" {
  for_each = try({ for collection in var.network_rule_collections : collection.name => collection }, toset([]))

  name                = each.key
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.virtual_network.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_addresses = rule.value.destination_addresses
      destination_ip_groups = rule.value.destination_ip_groups
      destination_fqdns     = rule.value.destination_fqdns
      destination_ports     = rule.value.destination_ports
      protocols             = rule.value.protocols
    }
  }
}

# Add firewall application rule collection
resource "azurerm_firewall_application_rule_collection" "application_rule_collection" {
  for_each = try({ for collection in var.application_rule_collections : collection.name => collection }, toset([]))

  name                = each.key
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.virtual_network.resource_group_name
  priority            = each.value.priority
  action              = each.value.action

  dynamic "rule" {
    for_each = each.value.rules
    content {
      name             = rule.value.name
      source_addresses = rule.value.source_addresses
      source_ip_groups = rule.value.source_ip_groups
      target_fqdns     = rule.value.target_fqdns
      dynamic "protocol" {
        for_each = rule.value.protocols
        content {
          port = protocol.value.port
          type = protocol.value.type
        }
      }
    }
  }
}

# Add firewall nat rule collection
resource "azurerm_firewall_nat_rule_collection" "nat_rule_collection" {
  for_each = try({ for collection in var.nat_rule_collections : collection.name => collection }, toset([]))

  name                = each.key
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = var.virtual_network.resource_group_name
  priority            = each.value.priority
  action              = each.value.action
  dynamic "rule" {
    for_each = each.value.rules
    content {
      name                  = rule.value.name
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_ports     = rule.value.destination_ports
      destination_addresses = [azurerm_public_ip.firewall_pip.ip_address]
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.translated_port
      protocols             = rule.value.protocols
    }
  }
}