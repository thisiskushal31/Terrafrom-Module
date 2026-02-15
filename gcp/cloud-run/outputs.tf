output "service_id" {
  description = "Cloud Run service ID"
  value       = google_cloud_run_v2_service.service.id
}

output "uri" {
  description = "Service URI"
  value       = google_cloud_run_v2_service.service.uri
}
