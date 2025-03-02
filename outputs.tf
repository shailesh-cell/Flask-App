output "key_vault_name" {
  value = module.key_vault.name
}

output "aci_name" {
  value = module.aci.name
}

output "aci_fqdn" {
  value = module.aci.fqdn
}

output "acr_id" {
  value = module.acr.id
}

output "acr_name" {
  value = module.acr.name
}

output "login_server" {
  value = module.acr.login_server
}