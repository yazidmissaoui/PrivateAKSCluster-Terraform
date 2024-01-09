data "azurerm_client_config" "current" {}

# Création du groupe de ressources
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Générer une clé d'accès pour le compte de stockage Azure
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.environment
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "private"
}

