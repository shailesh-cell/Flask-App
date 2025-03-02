data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}

locals {
  acr_exists = length(try(data.azurerm_container_registry.existing.id, "")) > 0
}

resource "azurerm_container_registry" "acr" {
  count               = local.acr_exists ? 0 : 1
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false
}
