resource "azurerm_resource_group" "rg" {
  name     = "${var.app_name}-${var.environment}-rg"
  location = var.location
}