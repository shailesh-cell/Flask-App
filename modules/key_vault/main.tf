# Key Vault Module

resource "azurerm_key_vault" "kv" {
  name                     = "${var.app_name}-${var.environment}-kv"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku_name                 = "standard"
  tenant_id                = var.tenant_id
  purge_protection_enabled = true
  
  lifecycle {
    ignore_changes = [sku_name, tenant_id]
  }
}

# Service Principal Access Policy
resource "azurerm_key_vault_role_assignment" "spn_policy" {
  scope = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  object_id    = var.spn_object_id
}

data "terraform_remote_state" "acr" {
  backend = "azurerm"
  config = {
    resource_group_name  = "terraform_tfstate_rg"
    storage_account_name = "terraformconfigsa"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }
}



# ACR Identity Access Policy
resource "azurerm_key_vault_role_assignment" "acr_policy" {
  scope = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets Officer"
  object_id    = var.acr_identity_principal_id # Passed from ACR module
}

# Store ACR Username in Key Vault
resource "azurerm_key_vault_secret" "acr_username" {
  name         = "acr-username"
  value        = "dummy-username"
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault.kv]
}

# Store ACR Password in Key Vault
resource "azurerm_key_vault_secret" "acr_password" {
  name         = "acr-password"
  value        = "dummy-password"
  key_vault_id = azurerm_key_vault.kv.id

  depends_on = [azurerm_key_vault.kv]
}