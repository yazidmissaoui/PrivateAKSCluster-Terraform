resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-k8s"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.aks-subnet.id
    temporary_name_for_rotation ="tempnode"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    service_cidr     = "172.16.0.0/16"
    dns_service_ip = "172.16.0.10"
  }

  identity {
    type = "SystemAssigned"
  }

 ingress_application_gateway {
    subnet_id = azurerm_subnet.app-gw-subnet.id
  }
  private_cluster_enabled = true
}

resource "azurerm_role_assignment" "example" {
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}

