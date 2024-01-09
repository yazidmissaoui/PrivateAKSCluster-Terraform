# Générer une clé d'accès pour le compte de stockage Azure
resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  public_network_access_enabled = true
  

  tags = {
    environment = var.environment
  }
  identity {
    type = "SystemAssigned"
  }
}
# ============PrivateLink for Storage Account====================
resource "azurerm_private_dns_zone" "storage-account-dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_endpoint" "storage" {
  name                = var.storage_endpoint
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  subnet_id = azurerm_subnet.private-endpoint-storage.id

  private_service_connection {
    name                           = format("pe-2%s",azurerm_storage_account.storage.name)
    private_connection_resource_id = azurerm_storage_account.storage.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.storage-account-dns.id]
  }

  tags = {
    environment = var.environment
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "storage-account-link" {
  name                  = "link-privateDnsZone-to-vnet"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.storage-account-dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}