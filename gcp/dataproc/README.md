# dataproc

Create a **Dataproc** cluster (managed Spark/Hadoop). Configures master and worker node groups, disk, and optional software overrides.

## Usage

```hcl
module "dataproc" {
  source     = "./gcp/dataproc"
  project_id = var.project_id
  name       = "my-cluster"
  region     = "us-central1"
  master_num_instances = 1
  worker_num_instances = 2
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`. Optional: `staging_bucket`, machine types, disk sizes, `override_properties`.

## Outputs

`cluster_id`, `cluster_name`.
