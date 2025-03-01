output "acr_id" {
  description = "The ID of the Azure Container Registry"
  value       = local.acr_id
}

output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = local.acr_name
}

output "acr_login_server" {
  description = "The login server of the Azure Container Registry"
  value       = "${local.acr_name}.azurecr.io"
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
  value       = azurerm_container_registry.acr.name
}