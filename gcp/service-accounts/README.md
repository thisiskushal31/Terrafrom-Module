# service-accounts

Standalone module: **service accounts** and optional project roles/keys. Only GCP resources here—no external module calls.

## Usage

```hcl
module "service_accounts" {
  source       = "./gcp/service-accounts"
  project_id   = var.project_id
  prefix       = "my-app"
  names        = ["runner", "worker"]
  project_roles = ["${var.project_id}=>roles/storage.objectViewer"]
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| project_id | Project ID | required |
| prefix | Prefix for SA IDs | `""` |
| names | SA name suffixes | `[]` |
| project_roles | List of `project_id=>roles/role` | `[]` |
| generate_keys | Generate keys | `false` |

## Outputs

- `service_accounts`, `emails`, `emails_list`
