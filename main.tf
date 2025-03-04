# ------------------------------------
# Resource Group Module
# ------------------------------------
module "resource_group" {
  source      = "./modules/resource_group"
  app_name    = var.app_name
  environment = var.environment
  location    = var.location
}

# ------------------------------------
# Azure Container Registry (ACR) Module
# ------------------------------------
module "acr" {
  source              = "./modules/acr"
  app_name            = var.app_name
  environment         = var.environment
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name

  depends_on = [module.resource_group]
}

# Debug output to check the value of acr_identity_principal_id
output "debug_acr_identity_principal_id" {
  value = module.acr.acr_identity_principal_id
}

# ------------------------------------
# Azure Key Vault Module
# ------------------------------------
module "key_vault" {
  source                     = "./modules/key_vault"
  app_name                   = var.app_name
  environment                = var.environment
  location                   = module.resource_group.rg_location
  tenant_id                  = var.tenant_id
  resource_group_name        = module.resource_group.rg_name
  acr_password               = var.acr_password
  acr_username               = var.acr_username
  acr_identity_principal_id  = module.acr.acr_identity_principal_id
  application_object_id      = var.spn_object_id
  spn_object_id              = var.spn_object_id

  depends_on = [module.resource_group, module.acr]
}

# ------------------------------------
# Azure Container Instances (ACI) Module
# ------------------------------------
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