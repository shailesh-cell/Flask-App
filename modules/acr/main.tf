data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}

resource "null_resource" "acr_check" {
  provisioner "local-exec" {
    command = length(data.azurerm_container_registry.existing.id) > 0 ? "echo ACR already exists" : "echo ACR does not exist, creating..."
  }

  triggers = {
    acr_id = length(data.azurerm_container_registry.existing.id) > 0 ? "exists" : "create"
  }
}

resource "azurerm_container_registry" "acr" {
  depends_on = [null_resource.acr_check]

  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
}

locals {
  acr_id   = coalesce(data.azurerm_container_registry.existing.id, azurerm_container_registry.acr.id)
  acr_name = coalesce(data.azurerm_container_registry.existing.name, azurerm_container_registry.acr.name)
}