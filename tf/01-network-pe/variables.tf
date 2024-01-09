variable "prefix" {
  description = "prefix"
  type        = string
}
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure Region"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "aks_node_count" {
  description = "Number of AKS nodes"
  type        = number
}

variable "aks_node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure AD Tenant ID"
  type        = string
}

variable "storage_endpoint" {
  description = "Private endpoint to account storage"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account"
  type        = string
}
variable "storage_account_id" {
  description = "ID the Azure Storage Account"
  type        = string
}

variable "ip_bastion_host" {
  description = "IP address name bastion host"
  type        = string
}

variable "linux_vm" {
  description = "linux vm"
  type        = string
}




variable "environment" {
  description = "Environment tag for resources"
  type        = string
}


