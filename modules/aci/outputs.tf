output "name" {
  description = "The name of the ACI instance"
  value       = azurerm_container_group.aci.name
}

output "fqdn" {
  description = "The Fully Qualified Domain Name (FQDN) for the ACI"
  value       = azurerm_container_group.aci.fqdn
}

output "aci_ip" {
  description = "The public IP address of the ACI"
  value       = azurerm_container_group.aci.ip_address
}

output "aci_identity_id" {
  description = "The ID of the ACI Managed Identity"
  value       = azurerm_container_group.aci.identity[0].principal_id
}
