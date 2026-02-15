# cloud-run

Deploy a **Cloud Run** (Gen 2) service from a container image. Configure scaling, CPU/memory, and environment variables. Use IAM (e.g. `google_cloud_run_service_iam_member`) separately to allow unauthenticated invocations if needed.

## Usage

```hcl
module "run" {
  source     = "./gcp/cloud-run"
  project_id = var.project_id
  name       = "my-service"
  region     = "us-central1"
  image      = "us-docker.pkg.dev/my-project/my-repo/my-image:latest"
  min_instances = 0
  max_instances = 5
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`, `region`, `image`.

## Outputs

`service_id`, `uri`.
