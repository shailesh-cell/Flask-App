output "key_vault_name" {
  value = module.keyvault.name
}

output "acr_name" {
  value = module.acr.name
}

output "aci_name" {
  value = module.aci.name
}

output "aci_fqdn" {
  value = module.aci.fqdn
}