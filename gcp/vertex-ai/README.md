# vertex-ai

Create **Vertex AI** resources: dataset (for training data) and/or endpoint (for model deployment). Enable one or both via `create_dataset` and `create_endpoint`.

## Usage

```hcl
# Dataset only
module "vertex_dataset" {
  source     = "./gcp/vertex-ai"
  project_id = var.project_id
  region     = "us-central1"
  create_dataset      = true
  dataset_display_name = "my-dataset"
}

# Endpoint only (for deploying a model later)
module "vertex_endpoint" {
  source     = "./gcp/vertex-ai"
  project_id = var.project_id
  region     = "us-central1"
  create_endpoint     = true
  endpoint_name       = "my-endpoint"
  endpoint_display_name = "My endpoint"
}
```

## Inputs

See `variables.tf`. Required: `project_id`. For dataset: `dataset_display_name` when `create_dataset = true`. For endpoint: `endpoint_name` when `create_endpoint = true`.

## Outputs

`dataset_id`, `dataset_name`, `endpoint_id`, `endpoint_name` (null when not created).
