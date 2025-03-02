module "resource_group" {
  source      = "./modules/resource_group"
  rg_name     = var.rg_name
  environment = var.environment
  location    = var.location
}

module "key_vault" {
  source                = "./modules/key_vault"
  app_name              = var.app_name
  environment           = var.environment
  location              = module.resource_group.rg_location
  tenant_id             = var.tenant_id
  resource_group_name  = module.resource_group.rg_name
  depends_on = [module.resource_group]
}

module "acr" {
  source              = "./modules/acr"
  acr_name            = var.app_name
  location            = module.resource_group.rg_location
  resource_group_name  = module.resource_group.rg_name
 
  depends_on = [module.resource_group]
}

module "aci" {
  source              = "./modules/aci"
  app_name            = var.app_name
  environment         = var.environment
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name
  acr_id              = module.acr.id
  acr_login_server    = module.acr.login_server
  aci_identity_id     = module.aci.aci_identity_id

  depends_on = [module.acr, module.key_vault]
}