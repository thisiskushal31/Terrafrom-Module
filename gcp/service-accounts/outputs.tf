output "service_accounts" {
  description = "Service account resources by name"
  value       = google_service_account.accounts
}

output "emails" {
  description = "SA emails by name"
  value       = { for k, v in google_service_account.accounts : k => v.email }
}

output "emails_list" {
  description = "SA emails as list"
  value       = [for v in google_service_account.accounts : v.email]
}
