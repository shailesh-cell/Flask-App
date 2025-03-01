data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}

resource "azurerm_container_registry" "acr" {
  count               = length(data.azurerm_container_registry.existing.id) == 0 ? 1 : 0
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity

  provisioner "local-exec" {
    command = length(data.azurerm_container_registry.existing.id) == 0 ? "echo 'Creating ACR'" : "echo 'ACR already exists'"
  }
}

locals {
  acr_id   = coalesce(data.azurerm_container_registry.existing.id, azurerm_container_registry.acr[0].id)
  acr_name = coalesce(data.azurerm_container_registry.existing.name, azurerm_container_registry.acr[0].name)
}
