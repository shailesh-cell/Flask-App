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

variable "key_vault_id" {
  description = "The ID of the Azure Key Vault where secrets will be stored"
  type        = string
}