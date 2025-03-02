# Try to Fetch Existing Key Vault
data "azurerm_key_vault" "existing" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = var.resource_group_name
}

# Create Key Vault if it doesn't exist
resource "azurerm_key_vault" "kv" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  # Use existing key vault if found
  lifecycle {
    ignore_changes = [sku_name, tenant_id]
  }
}
