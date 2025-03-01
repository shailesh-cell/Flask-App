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

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "acr_id" {
  description = "Azure Container Registry ID"
  type        = string
}

variable "acr_login_server" {
  description = "Azure Container Registry login server"
  type        = string
}

variable "image_tag" {
  description = "Tag for the container image"
  type        = string
  default     = "latest"
}

variable "container_port" {
  description = "Port to expose for the Flask app"
  type        = number
  default     = 5000
}

variable "aci_identity_id" {
  description = "Identity ID of the ACI for role assignment"
  type        = string
}