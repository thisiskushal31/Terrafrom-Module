output "ip_address" {
  description = "Front-end IP address of the load balancer"
  value       = local.address
}

output "backend_service_id" {
  description = "Backend service ID"
  value       = google_compute_backend_service.default.id
}

output "url_map_id" {
  description = "URL map ID"
  value       = google_compute_url_map.default.id
}

output "http_forwarding_rule_name" {
  description = "HTTP forwarding rule name (if created)"
  value       = length(google_compute_global_forwarding_rule.http) > 0 ? google_compute_global_forwarding_rule.http[0].name : null
}

output "https_forwarding_rule_name" {
  description = "HTTPS forwarding rule name (if created)"
  value       = length(google_compute_global_forwarding_rule.https) > 0 ? google_compute_global_forwarding_rule.https[0].name : null
}
