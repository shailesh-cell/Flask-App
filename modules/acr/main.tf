resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}${var.environment}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  identity {
    type = "SystemAssigned"
  }
}


# Assign the AcrPull role to the Service Principal
resource "azurerm_role_assignment" "acr_pull_role" {
  principal_id   = var.spn_object_id
  role_definition_name = "AcrPull"
  scope          = azurerm_container_registry.acr.id
}