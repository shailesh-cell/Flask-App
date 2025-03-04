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
# Azure Container Registry (ACR) Module - Step 1
# ------------------------------------
module "acr" {
  source              = "./modules/acr"
  app_name            = var.app_name
  environment         = var.environment
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name

  depends_on = [module.resource_group]
}

# Debug output to check ACR identity principal ID
output "debug_acr_identity_principal_id" {
  value = module.acr.acr_identity_principal_id
}

# ------------------------------------
# Azure Key Vault Module - Step 2 (After ACR)
# ------------------------------------
module "key_vault" {
  source                     = "./modules/key_vault"
  app_name                   = var.app_name
  environment                = var.environment
  location                   = module.resource_group.rg_location
  tenant_id                  = var.tenant_id
  resource_group_name        = module.resource_group.rg_name
  acr_identity_principal_id  = module.acr.acr_identity_principal_id # No cycle now
  application_object_id      = var.spn_object_id
  spn_object_id              = var.spn_object_id

  depends_on = [module.resource_group, module.acr]
}

# ------------------------------------
# ACR Secrets Module - Step 3 (After ACR & Key Vault)
# ------------------------------------
module "acr" {
  source        = "./modules/acr"
  key_vault_id  = module.key_vault.key_vault_id
  acr_username  = var.acr_username
  acr_password  = var.acr_password

  depends_on = [module.key_vault]
}

# ------------------------------------
# Azure Container Instances (ACI) Module - Step 4 (Final Deployment)
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

  depends_on = [module.acr, module.key_vault, module.acr_secrets]
}