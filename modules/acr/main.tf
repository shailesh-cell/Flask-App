data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}

locals {
  acr_exists = length(data.azurerm_container_registry.existing.*.id) > 0
}

resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity

  # Create the ACR only if it doesn't exist
  lifecycle {
    ignore_changes = local.acr_exists ? [all] : []
  }

  # Only apply if the ACR doesn't exist
  provisioner "local-exec" {
    when    = local.acr_exists ? "never" : "create"
    command = "echo ACR doesn't exist, creating..."
  }
}

# Use the coalesce function to get the ACR ID and name
locals {
  acr_id   = coalesce(data.azurerm_container_registry.existing.id, azurerm_container_registry.acr[0].id)
  acr_name = coalesce(data.azurerm_container_registry.existing.name, azurerm_container_registry.acr[0].name)
}
