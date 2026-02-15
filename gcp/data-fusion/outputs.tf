output "instance_id" {
  description = "Instance ID"
  value       = google_data_fusion_instance.instance.id
}

output "instance_name" {
  description = "Instance name"
  value       = google_data_fusion_instance.instance.name
}

output "service_account" {
  description = "Service account used by the instance"
  value       = google_data_fusion_instance.instance.service_account
}

output "tenant_project_id" {
  description = "Tenant project ID (for private instance)"
  value       = google_data_fusion_instance.instance.tenant_project_id
}
