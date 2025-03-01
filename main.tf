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
  location              = var.location
  tenant_id             = var.tenant_id
  terraform_spn_object_id = var.terraform_spn_object_id
  aci_identity_id       = module.aci.aci_identity_id   # ✅ Pass ACI ID
  resource_group_name   = module.resource_group.resource_group_name
  depends_on = [module.resource_group]
}

data "azurerm_key_vault_secret" "acr_password" {
  name         = "acr-password"
  key_vault_id = module.key_vault.key_vault.id
}

module "acr" {
  source              = "./modules/acr"
  app_name            = var.app_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  key_vault_id        = module.key_vault.key_vault.id
  acr_password        = data.azurerm_key_vault_secret.acr_password.value 
 
  depends_on = [module.resource_group]
}

module "aci" {
  source              = "./modules/aci"
  app_name            = var.app_name
  environment         = var.environment
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  acr_id              = module.acr.id
  acr_login_server    = module.acr.login_server
  key_vault_id        = module.keyvault.id
  aci_identity_id     = module.acr.identity_id

  depends_on = [module.acr, module.key_vault]
}