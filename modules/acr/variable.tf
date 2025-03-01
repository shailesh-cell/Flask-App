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

variable "acr_name" {
  description = "The name of the Azure Container Registry (if exists, use it)"
  type        = string
  default     = null  # Allow null to auto-generate


