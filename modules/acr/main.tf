# Check if ACR already exists
data "azurerm_container_registry" "existing" {
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
}

# Create ACR only if it doesn't exist
resource "azurerm_container_registry" "acr" {
  count               = length(data.azurerm_container_registry.existing.id) > 0 ? 0 : 1
  name                = "${var.app_name}acr${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                = "Standard"
  admin_enabled      = true
}

# Local variable to get the ACR ID (existing or new)
locals {
  acr_id       = coalesce(data.azurerm_container_registry.existing.id, try(azurerm_container_registry.acr[0].id, null))
  acr_name     = coalesce(data.azurerm_container_registry.existing.name, try(azurerm_container_registry.acr[0].name, null))
  acr_login    = coalesce(data.azurerm_container_registry.existing.admin_username, try(azurerm_container_registry.acr[0].admin_username, null))
  acr_password = coalesce(data.azurerm_container_registry.existing.admin_password, try(azurerm_container_registry.acr[0].admin_password, null))
}

# Store ACR Credentials in Key Vault
resource "azurerm_key_vault_secret" "acr_username" {
  name         = "${var.app_name}-acr-username"
  value        = local.acr_login
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "acr_password" {
  name         = "${var.app_name}-acr-password"
  value        = local.acr_password
  key_vault_id = var.key_vault_id
}