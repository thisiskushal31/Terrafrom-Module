output "group_id" {
  description = "Group ID (e.g. group email)"
  value       = google_cloud_identity_group.group.group_key[0].id
}

output "group_name" {
  description = "Resource name (groups/{group_id})"
  value       = google_cloud_identity_group.group.name
}
