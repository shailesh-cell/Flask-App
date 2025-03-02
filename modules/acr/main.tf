# Create ACR Container Group with Managed Identity

resource "azurerm_container_registry" "acr" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = true
}

data "azurerm_container_registry" "acr" {
  name                = azurerm_container_registry.acr.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_key_vault_secret" "acr_username" {
  name         = "acr-username"
  value        = data.azurerm_container_registry.acr.admin_username
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "acr_password" {
  name         = "acr-password"
  value        = data.azurerm_container_registry.acr.admin_password
  key_vault_id = var.key_vault_id
}