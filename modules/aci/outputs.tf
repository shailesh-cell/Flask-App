output "aci_id" {
  value = azurerm_container_group.aci.id
}

output "aci_identity_principal_id" {
  value = azurerm_container_group.aci.identity[0].principal_id
}

output "aci_name" {
  value = azurerm_container_group.aci.name
}

output "aci_fqdn" {
  value = azurerm_container_group.aci.fqdn
}