# data-fusion

Create a **Data Fusion** instance (BASIC or ENTERPRISE). Optionally use a private instance with `network_config` (network name + IP allocation CIDR).

## Usage

```hcl
module "data_fusion" {
  source     = "./gcp/data-fusion"
  project_id = var.project_id
  name       = "my-df"
  region     = "us-central1"
  type       = "ENTERPRISE"
}
# For private instance, set network_config = { network = "vpc-name", ip_allocation = "10.0.0.0/22" }
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`, `region`. Optional: `type`, `network_config`, `options`, `datafusion_version`.

## Outputs

`instance_id`, `instance_name`, `service_account`, `tenant_project_id`.
