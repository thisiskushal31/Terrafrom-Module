/**
 * Vault module: only Vault-specific IAM. Grants a service account (from service-accounts
 * module) access to a bucket (from cloud-storage) and KMS key (from kms) for HashiCorp Vault.
 * No bucket, no KMS key, no service account creation — only IAM bindings.
 */

resource "google_storage_bucket_iam_member" "vault_storage" {
  bucket = var.storage_bucket_name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${var.service_account_email}"
}

resource "google_kms_crypto_key_iam_member" "vault_encrypter" {
  crypto_key_id = var.kms_crypto_key_id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${var.service_account_email}"
}

resource "google_kms_crypto_key_iam_member" "vault_viewer" {
  crypto_key_id = var.kms_crypto_key_id
  role          = "roles/cloudkms.viewer"
  member        = "serviceAccount:${var.service_account_email}"
}
