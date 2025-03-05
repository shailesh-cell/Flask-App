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
  value = module.aci.aci_id
}

output "aci_identity_principal_id" {
  value = module.aci.aci_identity_principal_id
}

output "aci_name" {
  value = module.aci.aci_name
}

output "aci_fqdn" {
  value = module.aci.aci_fqdn
}

output "key_vault_id" {
  value = module.key_vault.key_vault_id
}

output "acr_identity_principal_id" {
  value = module.acr.acr_identity_principal_id
}