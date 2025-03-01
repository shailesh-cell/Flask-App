module "key_vault" {
  source       = "./modules/key_vault"
  app_name     = var.app_name
  environment  = var.environment
  location     = var.location
}

module "acr" {
  source              = "./modules/acr"
  app_name            = var.app_name
  environment         = var.environment
  location           = var.location
  resource_group_name = module.keyvault.resource_group_name
  key_vault_id        = module.keyvault.id
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