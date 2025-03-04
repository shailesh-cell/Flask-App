output "acr_id" {
  value = azurerm_container_registry.acr.id
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}

output "login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_identity_principal_id" {
  value = azurerm_container_registry.acr.identity[0].principal_id
}

# Output admin credentials for use in acr_secrets module
output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
}

output "acr_password" {
  value = azurerm_container_registry.acr.admin_password
}

