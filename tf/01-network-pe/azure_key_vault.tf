
# Création du coffre-fort Azure Key Vault
resource "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
  public_network_access_enabled = true
  purge_protection_enabled = true 
}

resource "azurerm_key_vault_access_policy" "client" {
key_vault_id = azurerm_key_vault.key_vault.id
tenant_id    = data.azurerm_client_config.current.tenant_id
object_id    = data.azurerm_client_config.current.object_id


  secret_permissions = ["Delete","Get", "Set"]
  key_permissions = ["Get","Create","Delete","List","Restore","Recover","UnwrapKey","WrapKey","Purge","Encrypt","Decrypt","Sign","Verify","GetRotationPolicy","SetRotationPolicy"
  ]
}


# ============PrivateLink for Key Vault==========================
resource "azurerm_private_dns_zone" "keyvault-dns" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_private_endpoint" "pe_kv" {
  name                = format("pe-2%s", azurerm_key_vault.key_vault.name)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.private-endpoint-kv.id

  private_service_connection {
    name                           = format("pse-2%s", var.key_vault_name)
    private_connection_resource_id = azurerm_key_vault.key_vault.id
    is_manual_connection           = false
    subresource_names = ["Vault"]
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "keyvault-link" {
  name                  = "link-keyvault-to-vnet"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.keyvault-dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}