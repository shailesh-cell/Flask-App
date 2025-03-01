# Try to Fetch Existing Key Vault
data "azurerm_key_vault" "existing" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = module.resource_group.rg_name
  count               = 1
}

# Create Key Vault Only if It Doesn't Exist
resource "azurerm_key_vault" "kv" {
  count               = try(length(data.azurerm_key_vault.existing[0].id), 0) > 0 ? 0 : 1
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = module.resource_group.rg_name
  location            = module.resource_group.rg_location
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  # Access Policy for Terraform
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.terraform_spn_object_id
    secret_permissions = ["Get", "List", "Set", "Delete"]
  }
}

# Local Variable for Key Vault ID (Handles Both Existing & New)
locals {
  key_vault_id = coalesce(
    try(data.azurerm_key_vault.existing[0].id, null),
    try(azurerm_key_vault.kv[0].id, null)
  )
}

# ✅ Assign RBAC for ACI to Access Key Vault Secrets
resource "azurerm_role_assignment" "aci_kv_access" {
  scope                = local.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.aci.aci_identity_id

  depends_on = [module.aci]  # Ensure ACI is created first
}