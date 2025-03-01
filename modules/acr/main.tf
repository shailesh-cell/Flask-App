# Try to Fetch Existing ACR
data "azurerm_container_registry" "existing" {
  name                = var.acr_name
  resource_group_name      = var.resource_group_name
}

# Create ACR only if it doesn't exist
resource "azurerm_container_registry" "acr" {
  count           = data.azurerm_container_registry.existing.id == "" ? 1 : 0
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name      = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
}

locals {
  acr_id   = coalesce(try(data.azurerm_container_registry.existing.id, null), try(azurerm_container_registry.acr["create"].id, null))
  acr_name = coalesce(try(data.azurerm_container_registry.existing.name, null), try(azurerm_container_registry.acr["create"].name, null))
}
