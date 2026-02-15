# vault

**Vault-only:** IAM bindings so a service account can use a GCS bucket and KMS key for HashiCorp Vault (storage backend + auto-unseal). This module does **not** create the bucket, KMS key, or service account — use **cloud-storage**, **kms**, and **service-accounts** for those. Dependencies are wired by the caller.

## Usage

```hcl
module "vault_bucket" {
  source     = "./gcp/cloud-storage"
  project_id = var.project_id
  name       = "my-vault-data"
  location   = "us"
}

module "vault_kms" {
  source     = "./gcp/kms"
  project_id = var.project_id
  key_ring   = "vault-unseal"
  keys       = [{ id = "vault-key" }]
}

module "vault_sa" {
  source     = "./gcp/service-accounts"
  project_id = var.project_id
  # ... create SA for Vault
}

module "vault" {
  source                = "./gcp/vault"
  service_account_email = module.vault_sa.email
  storage_bucket_name   = module.vault_bucket.name
  kms_crypto_key_id     = module.vault_kms.key_ids["vault-key"]
}
```

## Inputs

See `variables.tf`. Required: `service_account_email`, `storage_bucket_name`, `kms_crypto_key_id`.

## Outputs

`storage_bucket_iam_member`, `kms_crypto_key_iam_members` (for dependencies).
