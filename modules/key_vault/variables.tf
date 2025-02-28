variable "app_name" {
  description = "Application name (used for naming resources)"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "terraform_spn_object_id" {
  description = "Object ID of the Terraform Service Principal"
  type        = string
}

variable "aci_identity_id" {
  description = "Managed Identity ID for ACI to access Key Vault"
  type        = string
}