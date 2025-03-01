data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}

locals {
  acr_exists = length(try(data.azurerm_container_registry.existing.id, "")) > 0
}

locals {
  create_acr = local.acr_exists ? {} : {
    "${var.app_name}acr${var.environment}" = {
      name                = "${var.app_name}acr${var.environment}"
      resource_group_name = var.resource_group_name
      location            = var.location
      sku                 = "Standard"
      admin_enabled       = false  # ❌ No need for admin credentials with Managed Identity
    }
  }
}

resource "azurerm_container_registry" "acr" {
  for_each = local.create_acr

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  admin_enabled       = each.value.admin_enabled
}

locals {
  acr_id   = coalesce(try(data.azurerm_container_registry.existing.id, null), azurerm_container_registry.acr[*].id[0])
  acr_name = coalesce(try(data.azurerm_container_registry.existing.name, null), azurerm_container_registry.acr[*].name[0])
}