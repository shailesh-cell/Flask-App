data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}

resource "null_resource" "acr_creation" {
  provisioner "local-exec" {
    command = length(data.azurerm_container_registry.existing.id) == 0 ? "terraform apply -target=module.acr_creation" : "echo 'ACR already exists'"
  }

  triggers = {
    acr_id = length(data.azurerm_container_registry.existing.id) == 0 ? "create" : "exists"
  }
}

resource "azurerm_container_registry" "acr" {
  depends_on = [null_resource.acr_creation]

  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
}

# Use the coalesce function to get the ACR ID and name
locals {
  acr_id   = coalesce(data.azurerm_container_registry.existing.id, azurerm_container_registry.acr[0].id)
  acr_name = coalesce(data.azurerm_container_registry.existing.name, azurerm_container_registry.acr[0].name)
}
