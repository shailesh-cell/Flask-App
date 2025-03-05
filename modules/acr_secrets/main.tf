resource "azurerm_key_vault_secret" "acr_username" {
  name         = "acr-username"
  value        = var.acr_username
  key_vault_id = var.key_vault_id
 
 depends_on = [azurerm_key_vault.kv]

}

resource "azurerm_key_vault_secret" "acr_password" {
  name         = "acr-password"
  value        = var.acr_password
  key_vault_id = var.key_vault_id

  depends_on = [azurerm_key_vault.kv]
}