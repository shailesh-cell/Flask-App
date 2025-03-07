variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
}

variable "location" {
  description = "The location where the resource group will be created."
  type        = string
}
