# iam

Standalone module: **project IAM** bindings (additive). Only GCP resources here—no external module calls.

## Usage

```hcl
module "iam" {
  source   = "./gcp/iam"
  projects = [var.project_id]
  bindings = {
    "roles/viewer" = ["user:alice@example.com"]
    "roles/storage.objectAdmin" = ["group:storage-admins@example.com"]
  }
}
```

## Inputs

| Name | Description |
|------|-------------|
| projects | Project IDs |
| bindings | role => list of members |

## Outputs

- `projects`, `members`
