# secret-manager

Create **Secret Manager** secrets and optional first version. Use **gcp/iam** to grant access to secret names.

## Usage

```hcl
module "secrets" {
  source     = "./gcp/secret-manager"
  project_id = var.project_id
  secrets = {
    "my-api-key" = {
      labels                = { env = "prod" }
      replication_locations = null  # auto replication
    }
    "my-db-password" = {
      replication_locations = ["us-central1", "us-east1"]
      secret_data            = var.initial_db_password  # optional; add versions later via API/console
    }
  }
}
```

## Inputs

See `variables.tf`. Required: `project_id`. `secrets` is a map of secret_id => { labels, replication_locations (null = auto), deletion_protection, secret_data (optional) }.

## Outputs

`secret_ids`, `secret_names`. Use `secret_names` with **gcp/iam** for `roles/secretmanager.secretAccessor`.
