output "virtual_network" {
  value = azurerm_virtual_network.vnet
  depends_on = [
    azurerm_subnet.subnet
  ]
}

output "virtual_network_resource_group_name" {
  value       = azurerm_resource_group.resource_group.name
  description = "The name of the virtual network rg."
}

output "firewall_subnet_id" {
  value       = azurerm_subnet.subnet.id
  description = "The ID of the firewall subnet."
}

output "virtual_network_resource_group_location" {
  value       = azurerm_resource_group.resource_group.location
  description = "The name of the virtual network rg."
}