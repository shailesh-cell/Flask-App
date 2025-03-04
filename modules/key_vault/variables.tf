variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location where the Key Vault will be created."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription."
  type        = string
}

variable "acr_username" {
  description = "The username for the Azure Container Registry"
  type        = string
}

variable "acr_password" {
  description = "The password for the Azure Container Registry"
  type        = string
}

variable "application_object_id" {
  description = "The object ID of the application"
  type        = string
}

variable "spn_object_id" {
  description = "Service Principal Object ID to grant access to Key Vault"
  type        = string
}

output "acr_identity_principal_id" {
  value = var.acr_identity_principal_id
}
