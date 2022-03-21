output "firewall_public_ip" {
  value       = azurerm_public_ip.firewall_pip
  description = "The Private IP address of the Azure Firewall."
}

output "firewall" {
  value       = azurerm_firewall.firewall
  description = "The ID of the Azure Firewall."
}