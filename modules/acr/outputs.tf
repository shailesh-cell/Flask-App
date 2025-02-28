output "acr_id" {
  description = "The ID of the Azure Container Registry"
  value       = local.acr_id
}

output "acr_name" {
  description = "The name of the Azure Container Registry"
  value       = local.acr_name
}

output "acr_login_server" {
  description = "The login server of the Azure Container Registry"
  value       = "${local.acr_name}.azurecr.io"
}

output "acr_username_secret" {
  description = "The Key Vault secret name for the ACR username"
  value       = azurerm_key_vault_secret.acr_username.name
}

output "acr_password_secret" {
  description = "The Key Vault secret name for the ACR password"
  value       = azurerm_key_vault_secret.acr_password.name
}