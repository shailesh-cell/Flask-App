provider "azurerm" {
  features {
    template_deployment {
      delete_nested_items_during_deletion = true
    }
  }

  subscription_id = "a6435a3c-312e-41ed-878b-3118525f919a"
  tenant_id       = "21150d7d-bb5a-486f-86af-73c82a8240bc"
}