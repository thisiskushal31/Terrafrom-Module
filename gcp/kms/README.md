# kms

Create a **Cloud KMS** key ring and crypto keys, with optional IAM (encrypter/decrypter).

## Usage

```hcl
module "kms" {
  source     = "./gcp/kms"
  project_id = var.project_id
  location   = "us-central1"
  keyring    = "my-keyring"
  keys = [
    { name = "key1", prevent_destroy = true },
    { name = "key2", rotation_period = "2592000s" }
  ]
  key_iam_owners = {
    "key1" = ["serviceAccount:my-sa@project.iam.gserviceaccount.com"]
  }
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `location`, `keyring`. `keys` can be empty (key ring only). Optional: `key_iam_owners`, `key_iam_encrypters`, `key_iam_decrypters` (maps of key name => list of members).

## Outputs

`key_ring_id`, `key_ring_name`, `key_ids` (map name => id), `key_id_list`.
