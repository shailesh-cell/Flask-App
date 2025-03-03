module "resource_group" {
  source      = "./modules/resource_group"
  app_name    = var.app_name
  environment = var.environment
  location    = var.location
}

module "key_vault" {
  source                 = "./modules/key_vault"
  app_name               = var.app_name
  environment            = var.environment
  location               = module.resource_group.rg_location
  tenant_id              = var.tenant_id
  resource_group_name    = module.resource_group.rg_name
  acr_password           = var.acr_password
  acr_username           = var.acr_username
  acr_identity_principal_id             = module.acr.acr_identity_principal_id
  application_object_id  = var.spn_object_id
  spn_object_id          = var.spn_object_id
  depends_on             = [module.resource_group]
}

# Ensure Key Vault depends on ACR
resource "azurerm_key_vault_access_policy" "acr_access_policy" {
  key_vault_id = module.key_vault.key_vault_id
  tenant_id    = var.tenant_id
  object_id    = module.acr.acr_identity_principal_id

  secret_permissions = [
    "Get",
    "Set",
  ]

  depends_on = [module.acr]
}

module "acr" {
  source              = "./modules/acr"
  app_name            = var.app_name
  environment         = var.environment
  location            = module.resource_group.rg_location
  resource_group_name = module.resource_group.rg_name
  key_vault_id        = module.key_vault.key_vault_id

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