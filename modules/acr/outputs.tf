output "acr_id" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.id : null
}

output "acr_name" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.name : null
}

output "login_server" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.login_server : null
}