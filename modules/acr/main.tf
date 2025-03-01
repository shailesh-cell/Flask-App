# Try to Fetch Existing ACR
data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name      = var.resource_group_name
}

# Conditional count based on existence of ACR
locals {
  acr_exists = length(data.azurerm_container_registry.existing.id) > 0
}

# Create ACR only if it doesn't exist
resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr${var.environment}"
  count               = local.acr_exists ? 0 : 1
  resource_group_name      = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
}

# Create a null resource to handle dependencies
resource "null_resource" "acr" {
  count = local.acr_exists ? 1 : 0

  provisioner "local-exec" {
    command = "echo ACR already exists."
  }

  depends_on = [data.azurerm_container_registry.existing]
}

# Use the coalesce function to get the ACR ID and name
locals {
  acr_id   = coalesce(data.azurerm_container_registry.existing.id, azurerm_container_registry.acr[0].id)
  acr_name = coalesce(data.azurerm_container_registry.existing.name, azurerm_container_registry.acr[0].name)
}