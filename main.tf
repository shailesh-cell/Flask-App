module "key_vault" {
  source                = "./modules/key_vault"
  app_name    = var.app_name
  environment = var.environment
  location    = var.location
  tenant_id             = var.tenant_id
  terraform_spn_object_id = var.terraform_spn_object_id
  aci_identity_id       = module.aci.aci_identity_id   # ✅ Pass ACI ID
  resource_group_name   = module.resource_group.resource_group_name
}

module "acr" {
  source              = "./modules/acr"
  app_name            = var.app_name
  environment         = var.environment
  location           = var.location
  resource_group_name = module.keyvault.resource_group_name
  key_vault_id        = module.keyvault.id
  acr_password        = module.acr_password
}

module "aci" {
  source              = "./modules/aci"
  app_name            = var.app_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.keyvault.resource_group_name
  acr_id              = module.acr.id
  acr_login_server    = module.acr.login_server
  key_vault_id        = module.keyvault.id
  aci_identity_id     = module.acr.identity_id
}