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
