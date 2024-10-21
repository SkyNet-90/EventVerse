# Outputs
output "resource_group_name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.eventverse_rg.name
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.eventverse_aks.name
}

output "aks_cluster_fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = azurerm_kubernetes_cluster.eventverse_aks.kube_config[0].host
}

output "sql_server_name" {
  description = "The name of the SQL server."
  value       = azurerm_mssql_server.eventverse_sql_server.name
}

output "sql_database_name" {
  description = "The name of the SQL database."
  value       = azurerm_mssql_database.eventverse_db.name
}

output "storage_account_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.eventverse_storage.name
}

output "storage_container_name" {
  description = "The name of the storage container."
  value       = azurerm_storage_container.eventverse_media.name
}