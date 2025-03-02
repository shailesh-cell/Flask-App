variable "rg_name" {
  description = "The name of the resource group."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
}

variable "location" {
  description = "The location where the resources will be created."
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure subscription."
  type        = string
}

variable "app_name" {
  description = "The name of the application."
  type        = string
}

# Variables for ACR Module
variable "acr_sku" {
  description = "The SKU of the ACR."
  type        = string
  default     = "Standard"
}

variable "acr_admin_enabled" {
  description = "Should the admin user be enabled?"
  type        = bool
  default     = false
}

# Variables for ACI Module
variable "aci_image" {
  description = "The container image to use for the Azure Container Instance."
  type        = string
  default     = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
}

variable "aci_cpu" {
  description = "The number of CPUs for the Azure Container Instance."
  type        = number
  default     = 0.5
}

variable "aci_memory" {
  description = "The amount of memory for the Azure Container Instance in GB."
  type        = number
  default     = 1.5
}
