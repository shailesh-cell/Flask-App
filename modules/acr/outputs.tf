output "id" {
  description = "The ID of the Azure Container Registry"
  value       = azurerm_container_registry.acr[0].id  # ✅ Add [0]
}

output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = local.acr_name
}

output "login_server" {
  description = "The login server of the Azure Container Registry"
  value       = azurerm_container_registry.acr[0].login_server  # ✅ Add [0]
}

output "id" {
  description = "The ID of the Azure Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "login_server" {
  description = "The login server of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "name" {
  description = "The name of the Azure Container Registry"
  value       = azurerm_container_registry.acr[0].name  # ✅ Add [0]
}