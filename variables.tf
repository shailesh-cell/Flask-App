variable "app_name" {
  description = "Application name"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the Azure Resource Group"
  type        = string
}

variable "image_tag" {
  description = "The tag of the container image"
  type        = string
}

variable "acr_username" {
  description = "Username for Azure Container Registry"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}
