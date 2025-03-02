module "resource_group" {
  source      = "./modules/resource_group"
  app_name    = var.app_name
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
  acr_password         = var.acr_password
  acr_username         = var.acr_username
  depends_on = [module.resource_group]
}

module "acr" {
  source              = "./modules/acr"
  app_name            = var.app_name
  environment           = var.environment
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
  acr_id              = module.acr.acr_id
  acr_login_server    = module.acr.login_server
  image_tag           = var.image_tag
  container_port      = var.container_port

  depends_on = [module.acr, module.key_vault]
}