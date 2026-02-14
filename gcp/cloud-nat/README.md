# cloud-nat

Standalone module: **Cloud NAT** and optional **Cloud Router**. Only GCP resources here—no external module calls.

## Usage

```hcl
module "cloud_nat" {
  source        = "./gcp/cloud-nat"
  project_id    = var.project_id
  region        = "us-central1"
  router        = "my-router"
  create_router = true
  network       = module.network.network_self_link
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| project_id | Project ID | required |
| region | Region | required |
| router | Router name | required |
| create_router | Create router | `false` |
| network | VPC (required if create_router) | `""` |
| subnetworks | Per-subnet NAT config | `[]` |

## Outputs

- `router_name`, `nat_name`
