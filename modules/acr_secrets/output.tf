output "acr_username_secret_id" {
  value = azurerm_key_vault_secret.acr_username.id
}

output "acr_password_secret_id" {
  value = azurerm_key_vault_secret.acr_password.id
}
