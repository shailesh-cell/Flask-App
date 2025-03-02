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
  description = "The image tag for the container."
  type        = string
}

variable "container_port" {
  description = "The port on which the container listens."
  type        = number
}

variable "aci_cpu" {
  description = "The number of CPUs for the Azure Container Instance."
  type        = number
  default     = 1
}

variable "aci_memory" {
  description = "The amount of memory for the Azure Container Instance in GB."
  type        = number
  default     = 1.5
}