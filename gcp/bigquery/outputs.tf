output "dataset_id" {
  description = "Dataset ID"
  value       = google_bigquery_dataset.dataset.dataset_id
}

output "dataset" {
  description = "Dataset resource"
  value       = google_bigquery_dataset.dataset
}

output "tables" {
  description = "Table resources"
  value       = google_bigquery_table.tables
}

output "views" {
  description = "View resources"
  value       = google_bigquery_table.views
}
