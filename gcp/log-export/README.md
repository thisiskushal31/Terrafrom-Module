# log-export

Create a **log sink** at project, folder, organization, or billing account level. SRE: centralised logging, audit trails, log-based alerting. Create the destination (GCS bucket, Pub/Sub topic, or BigQuery dataset) separately and pass its URI.

## Usage

```hcl
# Destination bucket (e.g. from gcp/cloud-storage)
module "bucket" {
  source     = "./gcp/cloud-storage"
  project_id = var.project_id
  name       = "my-log-export-bucket"
  # ...
}

module "log_export" {
  source               = "./gcp/log-export"
  project_id           = var.project_id
  log_sink_name        = "errors-to-gcs"
  destination_uri      = "storage.googleapis.com/${module.bucket.name}"
  parent_resource_type = "project"
  parent_resource_id  = var.project_id
  filter               = "severity>=ERROR"
  unique_writer_identity = true
}
# Grant module.log_export.writer_identity write access to the bucket (e.g. via gcp/iam or bucket IAM).
```

## Inputs

See `variables.tf`. Required: `log_sink_name`, `destination_uri`, `parent_resource_id`. Optional: `filter`, `parent_resource_type` (project/folder/organization/billing_account), `bigquery_use_partitioned_tables`, `exclusions`.

## Outputs

`writer_identity` (grant this principal access to the destination), `sink_id`.
