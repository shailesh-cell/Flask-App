# Check if Key Vault already exists
data "azurerm_key_vault" "existing" {
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = var.resource_group_name
}

# Create Key Vault only if it doesn't exist
resource "azurerm_key_vault" "kv" {
  count               = length(data.azurerm_key_vault.existing.id) > 0 ? 0 : 1
  app_name            = var.app_name
  environment         = var.environment
  name                = "${var.app_name}-${var.environment}-kv"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "standard"
  tenant_id           = var.tenant_id

  # Access Policy for Terraform
  access_policy {
    tenant_id = var.tenant_id
    object_id = var.terraform_spn_object_id
    secret_permissions = [
      "Get", "List", "Set", "Delete"
    ]
  }
}

# Local variable to get the Key Vault ID (existing or new)
locals {
  key_vault_id = coalesce(
    data.azurerm_key_vault.existing.id,
    try(azurerm_key_vault.kv[0].id, null)
  )
}

# Assign RBAC for ACI to access Key Vault secrets
resource "azurerm_role_assignment" "aci_kv_access" {
  scope                = local.key_vault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = var.aci_identity_id
}