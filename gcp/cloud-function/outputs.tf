output "function_name" {
  description = "Cloud Function name"
  value       = google_cloudfunctions_function.function.name
}

output "function_id" {
  description = "Cloud Function ID"
  value       = google_cloudfunctions_function.function.id
}

output "https_trigger_url" {
  description = "HTTPS trigger URL (when trigger_http = true)"
  value       = google_cloudfunctions_function.function.https_trigger_url
}
