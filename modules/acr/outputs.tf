output "acr_id" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.id : (length(local.create_acr) > 0 ? azurerm_container_registry.acr.values().*id[0] : null)
}

output "acr_name" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.name : (length(local.create_acr) > 0 ? azurerm_container_registry.acr.values().*name[0] : null)
}

output "login_server" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.login_server : (length(local.create_acr) > 0 ? azurerm_container_registry.acr.values().*login_server[0] : null)
}

