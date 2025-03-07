output "key_vault_id" {
  value = azurerm_key_vault.kv.id
}

output "name" {
  description = "The name of the Key Vault"
  value       = azurerm_key_vault.kv.name
}

output "acr_identity_principal_id" {
  value = var.acr_identity_principal_id
}

output "key_vault_name" {
  value = azurerm_key_vault.kv.name
}
