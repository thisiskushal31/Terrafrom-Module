output "index_ids" {
  description = "Map of index key => index ID"
  value       = { for k, idx in google_datastore_index.index : k => idx.id }
}
