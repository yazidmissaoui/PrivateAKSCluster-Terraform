
# Configure Azure Storage Account Backend for Terraform
terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "monitoring_stack"
    storage_account_name = "monitoringstacksa"
    container_name       = "akscluster"
    key                  = "master"
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}
