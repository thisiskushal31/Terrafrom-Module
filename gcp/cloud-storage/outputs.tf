output "buckets" {
  description = "Bucket resources by name"
  value       = google_storage_bucket.buckets
}

output "names" {
  description = "Bucket names by key"
  value       = { for k, v in google_storage_bucket.buckets : k => v.name }
}

output "urls" {
  description = "Bucket URLs by key"
  value       = { for k, v in google_storage_bucket.buckets : k => v.url }
}
