output "cluster_name" {
  description = "GKE cluster name"
  value       = google_container_cluster.primary.name
}

output "cluster_id" {
  description = "Cluster ID (project/location/name)"
  value       = google_container_cluster.primary.id
}

output "cluster_endpoint" {
  description = "Cluster API endpoint"
  value       = google_container_cluster.primary.endpoint
  sensitive   = true
}

output "kubernetes_version" {
  description = "Current Kubernetes version (master)"
  value       = google_container_cluster.primary.current_master_version
}

output "location" {
  description = "Cluster location (region)"
  value       = google_container_cluster.primary.location
}

# Per-pool service account emails. Use with gcp/iam to grant roles to each pool.
output "node_pool_service_accounts" {
  description = "Map of node pool name to service account email. Pass to gcp/iam to manage roles."
  value = {
    for k, v in google_container_node_pool.pool :
    k => (var.node_pools[k].service_account != null ? var.node_pools[k].service_account : try(v.node_config[0].service_account, null))
  }
}

output "storageclass_id" {
  description = "Default storage class ID (standard for GKE)"
  value       = "standard"
}

output "gcp_cloud" {
  description = "GCP cloud details (project, network, subnetwork, region, cluster name)"
  value = {
    project_id      = var.project_id
    network_name    = local.network_name
    subnetwork_name = local.subnetwork_name
    region          = var.region
    cluster_name    = google_container_cluster.primary.name
  }
}

output "k8s_details" {
  description = "Kubernetes cluster details (version, name, node pool SAs, storage class)"
  value = {
    kubernetes_version         = google_container_cluster.primary.current_master_version
    cluster_name               = google_container_cluster.primary.name
    node_pool_service_accounts = { for k, v in google_container_node_pool.pool : k => (var.node_pools[k].service_account != null ? var.node_pools[k].service_account : try(v.node_config[0].service_account, null)) }
    storageclass_id            = "standard"
  }
}
