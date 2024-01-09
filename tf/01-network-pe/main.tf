data "azurerm_client_config" "current" {}

# Création du groupe de ressources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

