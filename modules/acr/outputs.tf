output "acr_id" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.id : azurerm_container_registry.acr[each.key].id
}

output "acr_name" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.name : azurerm_container_registry.acr[each.key].name
}

output "login_server" {
  value = local.acr_exists ? data.azurerm_container_registry.existing.login_server : azurerm_container_registry.acr[each.key].login_server
}

