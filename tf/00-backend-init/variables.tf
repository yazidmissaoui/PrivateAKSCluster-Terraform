variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  type        = string
}

variable "container_name" {
  description = "Container name for AKS"
  type        = string
}

variable "environment" {
  description = "Environment tag for resources"
  type        = string
}

