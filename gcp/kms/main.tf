/**
 * Standalone KMS module: key ring + crypto keys + optional IAM.
 * Only google_kms_* resources—no module calls.
 */

resource "google_kms_key_ring" "key_ring" {
  name     = var.keyring
  project  = var.project_id
  location = var.location
}

resource "google_kms_crypto_key" "key" {
  count            = length(var.keys)
  name             = var.keys[count.index].name
  key_ring         = google_kms_key_ring.key_ring.id
  purpose          = try(var.keys[count.index].purpose, "ENCRYPT_DECRYPT")
  rotation_period  = try(var.keys[count.index].rotation_period, var.key_rotation_period)
  protection_level = try(var.keys[count.index].protection_level, var.key_protection_level)

  version_template {
    algorithm        = try(var.keys[count.index].algorithm, var.key_algorithm)
    protection_level = try(var.keys[count.index].protection_level, var.key_protection_level)
  }

  lifecycle {
    prevent_destroy = try(var.keys[count.index].prevent_destroy, var.prevent_destroy)
  }

  labels = try(var.keys[count.index].labels, var.labels)
}

locals {
  keys_by_name = { for i, k in google_kms_crypto_key.key : var.keys[i].name => k.id }
}

resource "google_kms_crypto_key_iam_binding" "owners" {
  for_each      = var.key_iam_owners
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  crypto_key_id = local.keys_by_name[each.key]
  members       = each.value
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  for_each      = var.key_iam_encrypters
  role          = "roles/cloudkms.cryptoKeyEncrypter"
  crypto_key_id = local.keys_by_name[each.key]
  members       = each.value
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  for_each      = var.key_iam_decrypters
  role          = "roles/cloudkms.cryptoKeyDecrypter"
  crypto_key_id = local.keys_by_name[each.key]
  members       = each.value
}
