# dataflow

Run a **Dataflow** job: Flex Template (container_spec_gcs_path) or classic template (template_gcs_path). Create the staging/temp bucket separately (e.g. with gcp/cloud-storage).

## Usage

```hcl
# Flex Template
module "dataflow" {
  source     = "./gcp/dataflow"
  project_id = var.project_id
  name       = "my-job"
  region     = "us-central1"
  use_flex_template = true
  container_spec_gcs_path = "gs://my-bucket/templates/flex-template.json"
  temp_location          = "gs://my-bucket/temp"
  parameters = { input = "gs://..." }
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`. For Flex: `container_spec_gcs_path`, `temp_location`. For classic: `template_gcs_path`, `temp_gcs_location`.

## Outputs

`job_id`, `job_state`.
