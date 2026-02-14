output "key_ring_id" {
  description = "Key ring ID (self link)"
  value       = google_kms_key_ring.key_ring.id
}

output "key_ring_name" {
  description = "Key ring name"
  value       = google_kms_key_ring.key_ring.name
}

output "key_ids" {
  description = "Map of key name => crypto key ID (self link)"
  value       = local.keys_by_name
}

output "key_id_list" {
  description = "List of crypto key IDs"
  value       = [for k in google_kms_crypto_key.key : k.id]
}
