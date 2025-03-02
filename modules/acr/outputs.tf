output "acr_id" {
  value = length(try(data.azurerm_container_registry.existing.id, "")) > 0 ? data.azurerm_container_registry.existing.id : (count.index[0] ? azurerm_container_registry.acr.id : null)
}

output "acr_name" {
  value = length(try(data.azurerm_container_registry.existing.id, "")) > 0 ? data.azurerm_container_registry.existing.name : (count.index[0] ? azurerm_container_registry.acr.name : null)
}

output "login_server" {
  value = length(try(data.azurerm_container_registry.existing.id, "")) > 0 ? data.azurerm_container_registry.existing.login_server : (count.index[0] ? azurerm_container_registry.acr.login_server : null)
}