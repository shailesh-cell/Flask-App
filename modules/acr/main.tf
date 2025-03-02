# Create ACR Container Group with Managed Identity

resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}
