# Root outputs.tf file

output "rg_name" {
  value = module.resource_group.rg_name
}

output "rg_location" {
  value = module.resource_group.rg_location
}

output "key_vault_name" {
  value = module.key_vault.name
}

output "acr_id" {
  value = module.acr.acr_id
}

output "acr_name" {
  value = module.acr.acr_name
}

output "login_server" {
  value = module.acr.login_server
}

output "aci_id" {
  value = var.deploy_aci ? module.aci[0].aci_id : null
}

output "aci_identity_principal_id" {
  value = var.deploy_aci ? module.aci[0].aci_identity_principal_id : null
}

output "aci_name" {
  value = var.deploy_aci ? module.aci[0].aci_name : null
}

output "aci_fqdn" {
  value = var.deploy_aci ? module.aci[0].aci_fqdn : null
}

output "key_vault_id" {
  value = module.key_vault.key_vault_id
}

output "acr_identity_principal_id" {
  value = module.acr.acr_identity_principal_id
}