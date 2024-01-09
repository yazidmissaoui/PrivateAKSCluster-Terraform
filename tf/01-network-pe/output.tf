/*output "aks_cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "aks_cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_cluster_fqdn" {
  value = azurerm_kubernetes_cluster.aks_cluster.fqdn
}*/

output kv_private_ip {
  value =   ["1.2.3.4"]
}