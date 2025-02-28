terraform {
  backend "azurerm" {
    resource_group_name   = "terraform_tfstate_rg"
    storage_account_name  = "terraformconfigsa"
    container_name        = "tfstate"
    key                   = ""aci-${var.environment}.tfstate"
    use_oidc              = true  # Enable OIDC authentication
  }
}