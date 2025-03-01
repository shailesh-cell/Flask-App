
# Create ACI Container Group
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

    secure_environment_variables = {
      ACR_USERNAME = data.azurerm_key_vault_secret.acr_username.value
      ACR_PASSWORD = data.azurerm_key_vault_secret.acr_password.value
    }
  }

  image_registry_credential {
    server   = var.acr_login_server
    username = data.azurerm_key_vault_secret.acr_username.value
    password = data.azurerm_key_vault_secret.acr_password.value
  }

  dns_name_label = "${var.app_name}-${var.environment}"
  ip_address_type = "Public"
}

# Assign ACI Access to ACR (if RBAC is needed)
resource "azurerm_role_assignment" "aci_acr_pull" {
  principal_id         = module.aci.aci_identity_id
  role_definition_name = "AcrPull"
  scope                = module.acr.acr_id
  depends_on           = [module.aci]
}