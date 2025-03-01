# Try to Fetch Existing ACR
data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name      = var.resource_group_name
}

# Create ACR only if it doesn't exist
resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr${var.environment}"
  count               = length(try(data.azurerm_container_registry.existing[0].id, "")) > 0 ? 0 : 1
  resource_group_name      = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
}

locals {
  acr_id   = coalesce(try(data.azurerm_container_registry.existing[0].id, null), try(azurerm_container_registry.acr[0].id, null))
  acr_name = coalesce(try(data.azurerm_container_registry.existing[0].name, null), try(azurerm_container_registry.acr[0].name, null))
}
