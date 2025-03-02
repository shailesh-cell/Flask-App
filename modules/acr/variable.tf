variable "acr_name" {
  description = "The name of the Azure Container Registry."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location where the ACR will be created."
  type        = string
}

variable "sku" {
  description = "The SKU of the ACR."
  type        = string
  default     = "Standard"
}

variable "admin_enabled" {
  description = "Should the admin user be enabled?"
  type        = bool
  default     = false
}
