terraform {
  backend "azurerm" {
    use_oidc = true # Enable OIDC authentication
  }
}