data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}


resource "null_resource" "create_acr" {
  count = length(try(data.azurerm_container_registry.existing.id, "")) == 0 ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
    terraform apply -target=azurerm_container_registry.acr
    EOT
  }
}

resource "azurerm_container_registry" "acr" {
  count               = length(try(data.azurerm_container_registry.existing.id, "")) == 0 ? 1 : 0
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
  admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
}
