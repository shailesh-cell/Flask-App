# module aci

# Create ACI Container Group with Managed Identity
resource "azurerm_container_group" "aci" {
  name                = "${var.app_name}-${var.environment}-aci"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"

  identity {
    type = "SystemAssigned"
  }

  container {
    name   = var.app_name
    image  = "${var.acr_login_server}/${var.app_name}:${var.image_tag}"
    cpu    = 1
    memory = 1.5

    ports {
      port     = var.container_port
      protocol = "TCP"
    }

    environment_variables = {
      FLASK_ENV = var.environment
    }
  }

  dns_name_label  = "${var.app_name}-${var.environment}"
  ip_address_type = "Public"
}

# Assign ACI Access to ACR using Managed Identity
resource "azurerm_role_assignment" "aci_acr_pull" {
  principal_id         = azurerm_container_group.aci.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = var.acr_id
}