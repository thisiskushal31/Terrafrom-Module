# cloud-storage

Standalone module: **GCS buckets** with optional versioning and labels. Only GCP resources here—no external module calls.

## Usage

```hcl
module "gcs" {
  source     = "./gcp/cloud-storage"
  project_id = var.project_id
  names      = ["data", "logs"]
  prefix     = "my-org"
  location   = "US"
  versioning = { data = true }
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| project_id | Project ID | required |
| names | Bucket name suffixes | required |
| prefix | Name prefix | `""` |
| location | Location | `"US"` |
| versioning | Per-bucket versioning | `{}` |
| labels | Labels | `{}` |

## Outputs

- `buckets`, `names`, `urls`
