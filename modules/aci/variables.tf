variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, uat, prod)."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location where the ACI will be created."
  type        = string
}

variable "acr_id" {
  description = "The ID of the Azure Container Registry."
  type        = string
}

variable "acr_login_server" {
  description = "The login server of the Azure Container Registry."
  type        = string
}

variable "image_tag" {
  description = "The tag for the container image."
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens."
  type        = number
}