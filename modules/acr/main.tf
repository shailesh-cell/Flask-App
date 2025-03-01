# Try to Fetch Existing ACR
data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name      = var.resource_group_name
}

# Create ACR only if it doesn't exist
resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr${var.environment}"
  count               = data.azurerm_container_registry.existing.id == "" ? 1 : 0
  resource_group_name      = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
}

locals {
  acr_id   = coalesce(data.azurerm_container_registry.existing.id, azurerm_container_registry.acr[0].id)
  acr_name = coalesce(data.azurerm_container_registry.existing.name, azurerm_container_registry.acr[0].name)
}

