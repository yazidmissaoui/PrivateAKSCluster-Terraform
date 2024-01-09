# ============Virtual network with subnets================================================
resource "azurerm_network_security_group" "nsg-vnet" {
  name                = "network-security-group"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}


resource "azurerm_virtual_network" "vnet" {
  name                = "monitoring-stack-network"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]

}
resource "azurerm_subnet" "aks-subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "aks-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/22"]
}
resource "azurerm_subnet" "private-endpoint-storage" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "private-endpoint-storage"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.4.0/24"]
}
resource "azurerm_subnet" "private-endpoint-kv" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "private-endpoint-kv"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.5.0/24"]
}
resource "azurerm_subnet" "private-endpoint-acr" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "private-endpoint-acr"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.6.0/24"]
}
resource "azurerm_subnet" "AzureBastionSubnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "AzureBastionSubnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.7.0/24"]
}
resource "azurerm_subnet" "vm-bastion-subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "vm-bastion-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.8.0/24"]
}
resource "azurerm_subnet" "mysql-subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "mysql-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.9.0/24"]
}
resource "azurerm_subnet" "app-subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "app-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.10.0/24"]
}
resource "azurerm_subnet" "app-gw-subnet" {
  resource_group_name  = azurerm_resource_group.rg.name
  name                 = "app-gw-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.11.0/24"]
}
resource "azurerm_public_ip" "ip-bastion-host" {
  name                = var.ip_bastion_host
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  name                = "bastion"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.AzureBastionSubnet.id
    public_ip_address_id = azurerm_public_ip.ip-bastion-host.id
  }
}