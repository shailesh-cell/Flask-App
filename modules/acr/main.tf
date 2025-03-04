resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true

  identity {
    type = "SystemAssigned"
  }
}