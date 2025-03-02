output "acr_id" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.id : (length(azurerm_container_registry.acr) > 0 ? azurerm_container_registry.acr[0].id : null)
}

output "acr_name" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.name : (length(azurerm_container_registry.acr) > 0 ? azurerm_container_registry.acr[0].name : null)
}

output "login_server" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.login_server : (length(azurerm_container_registry.acr) > 0 ? azurerm_container_registry.acr[0].login_server : null)
}