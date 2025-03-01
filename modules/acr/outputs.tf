output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = local.acr_name
}


output "id" {
  value = azurerm_container_registry.acr.id
}

output "login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "name" {
  value = azurerm_container_registry.acr.name
}
