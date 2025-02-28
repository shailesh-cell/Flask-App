output "key_vault_id" {
  description = "The ID of the Azure Key Vault"
  value       = local.key_vault_id
}

output "key_vault_name" {
  description = "The name of the Azure Key Vault"
  value       = coalesce(
    data.azurerm_key_vault.existing.name,
    try(azurerm_key_vault.kv[0].name, null)
  )
}