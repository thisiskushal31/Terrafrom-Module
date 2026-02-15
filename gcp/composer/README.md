# composer

Create a **Cloud Composer 2** environment (managed Airflow). Requires a VPC network and subnetwork. The module grants the Composer Service Agent the required role unless disabled.

## Usage

```hcl
module "composer" {
  source     = "./gcp/composer"
  project_id = var.project_id
  name       = "my-composer"
  region     = "us-central1"
  network    = module.network.network_name
  subnetwork = "default"
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`, `network`, `subnetwork`. Optional: `region`, `image_version`, `environment_size`, workload sizes, `pypi_packages`, `env_variables`.

## Outputs

`environment_id`, `environment_name`, `gcs_dag_bucket`, `airflow_uri`.
