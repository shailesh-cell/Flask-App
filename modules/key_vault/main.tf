# Try to Fetch Existing Key Vault
data "azurerm_key_vault" "existing" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = var.resource_group.rg_name
  count               = 1
}

resource "azurerm_key_vault" "kv" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name      = module_resource_group.rg_name
  location            = module.resource_group.rg_location
  sku_name            = "standard"
  tenant_id           = var.tenant_id
}