output "cluster_id" {
  description = "Dataproc cluster ID"
  value       = google_dataproc_cluster.cluster.id
}

output "cluster_name" {
  description = "Cluster name"
  value       = google_dataproc_cluster.cluster.name
}
