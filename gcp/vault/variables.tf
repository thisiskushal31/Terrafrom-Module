variable "service_account_email" {
  type        = string
  description = "Service account email (from service-accounts module) that Vault will use"
}

variable "storage_bucket_name" {
  type        = string
  description = "GCS bucket name (from cloud-storage module) for Vault storage backend"
}

variable "kms_crypto_key_id" {
  type        = string
  description = "Full KMS crypto key ID (from kms module), e.g. projects/PROJECT/locations/REGION/keyRings/RING/cryptoKeys/KEY"
}
