

# ============Azure container registrey====================================================
resource "azurerm_container_registry" "acr" {
  name                     = "monitoringstackacr"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku                      = "Premium"
  admin_enabled            = true
  public_network_access_enabled = false
}

# ============PrivateLink for ACR=================================
resource "azurerm_private_dns_zone" "acr-dns" {
  name                = "privatelink.azurecr.io"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_endpoint" "pe_acr" {
  name                = format("pe-2%s", azurerm_container_registry.acr.name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.private-endpoint-acr.id

  private_service_connection {
    name                           = format("pse-2%s", azurerm_container_registry.acr.name)
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names          = ["registry"]
  }
   private_dns_zone_group {
    name                      = azurerm_private_dns_zone.acr-dns.name
    private_dns_zone_ids      = [azurerm_private_dns_zone.acr-dns.id]
  }  
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr-link" {
  name                  = "link-acr-to-vnet"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.acr-dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}