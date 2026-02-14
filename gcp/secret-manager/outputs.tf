output "secret_ids" {
  description = "Map of secret_id => full secret resource name"
  value       = { for k, s in google_secret_manager_secret.secret : k => s.id }
}

output "secret_names" {
  description = "Map of secret_id => secret name (for IAM)"
  value       = { for k, s in google_secret_manager_secret.secret : k => s.name }
}
