output "storage_bucket_iam_member" {
  description = "Storage bucket IAM binding (for dependency)"
  value       = google_storage_bucket_iam_member.vault_storage.member
}

output "kms_crypto_key_iam_members" {
  description = "KMS crypto key IAM bindings (for dependency)"
  value       = [google_kms_crypto_key_iam_member.vault_encrypter.member, google_kms_crypto_key_iam_member.vault_viewer.member]
}
