output "policy_name" {
  description = "Full policy name"
  value       = google_org_policy_policy.policy.name
}

output "policy_id" {
  description = "Policy ID"
  value       = google_org_policy_policy.policy.id
}
