output "rg_name" {
  value       = azurerm_resource_group.rg.name
  description = "Resource Group Name"
}

output "rg_location" {
  value       = azurerm_resource_group.rg.location
  description = "Location"
}

output "rg_id" {
  value       = azurerm_resource_group.rg.id
  description = "Resource Group ID"
}

output "vnet_name" {
  value       = azurerm_virtual_network.vnet.name
  description = "vNet Name"
}

output "vnet_id" {
  value       = azurerm_virtual_network.vnet.id
  description = "vNet ID"
}

output "subnet_name" {
  value       = azurerm_subnet.snet.name
  description = "Subnet name"
}

output "subnet_id" {
  value       = azurerm_subnet.snet.id
  description = "Subnet ID"
}


