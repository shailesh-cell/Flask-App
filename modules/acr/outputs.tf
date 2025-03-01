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