output "cluster_id" {
  description = "AKS cluster ID"
  value       = azurerm_kubernetes_cluster.cluster.id
}

output "cluster_name" {
  description = "AKS cluster name"
  value       = azurerm_kubernetes_cluster.cluster.name
}

output "cluster_fqdn" {
  description = "FQDN of the cluster API server"
  value       = azurerm_kubernetes_cluster.cluster.fqdn
}

output "kube_config_raw" {
  description = "Raw kube config (use with care; prefer OIDC/CLI)"
  value       = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive   = true
}

output "kube_admin_config_raw" {
  description = "Raw kube admin config"
  value       = azurerm_kubernetes_cluster.cluster.kube_admin_config_raw
  sensitive   = true
}

output "node_resource_group" {
  description = "Resource group where AKS places node pool resources"
  value       = azurerm_kubernetes_cluster.cluster.node_resource_group
}

output "oidc_issuer_url" {
  description = "OIDC issuer URL for workload identity"
  value       = azurerm_kubernetes_cluster.cluster.oidc_issuer_url
}

output "azure_cloud" {
  description = "Cluster details for use by callers (resource group, name, location)"
  value = {
    resource_group_name = var.resource_group_name
    cluster_name       = azurerm_kubernetes_cluster.cluster.name
    location           = var.location
    kubernetes_cluster_id = azurerm_kubernetes_cluster.cluster.id
  }
}
