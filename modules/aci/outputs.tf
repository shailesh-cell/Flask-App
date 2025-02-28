output "aci_name" {
  description = "The name of the ACI instance"
  value       = azurerm_container_group.aci.name
}

output "aci_fqdn" {
  description = "The Fully Qualified Domain Name (FQDN) for the ACI"
  value       = azurerm_container_group.aci.fqdn
}

output "aci_ip" {
  description = "The public IP address of the ACI"
  value       = azurerm_container_group.aci.ip_address
}