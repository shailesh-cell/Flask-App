# Try to Fetch Existing Key Vault
data "azurerm_key_vault" "existing" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = module.resource_group.rg_name
  count               = 1
}

resource "azurerm_key_vault" "kv" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = var.resource_group
  location            = var.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.terraform_spn
    secret_permissions = ["Get", "List", "Set", "Delete"]
  }
}