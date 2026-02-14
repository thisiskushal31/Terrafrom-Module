# network

Standalone module: **VPC** (network), subnets, routes, firewall rules, and optional **Private Service Access** (e.g. for Cloud SQL private IP). One VPC module; no separate PSA module. Only GCP resources here—no external module calls.

## Usage

```hcl
module "network" {
  source       = "./gcp/network"
  project_id   = var.project_id
  network_name = "my-vpc"
  subnets = [
    { subnet_name = "subnet-01", subnet_ip = "10.10.10.0/24", subnet_region = "us-west1" },
    { subnet_name = "subnet-02", subnet_ip = "10.10.20.0/24", subnet_region = "us-west1", subnet_private_access = true },
  ]
  ingress_rules = [
    { name = "allow-ssh", source_ranges = ["0.0.0.0/0"], allow = [{ protocol = "tcp", ports = ["22"] }] },
  ]
  # Optional: enable Private Service Access (e.g. for Cloud SQL private IP)
  enable_private_service_access = true
  private_service_access_prefix_length = 16
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| project_id | Project ID | required |
| network_name | VPC name | required |
| subnets | List of subnets | required |
| routing_mode | GLOBAL or REGIONAL | `"GLOBAL"` |
| secondary_ranges | Secondary ranges per subnet | `{}` |
| routes | Custom routes | `[]` |
| ingress_rules / egress_rules | Firewall rules | `[]` |
| auto_create_subnetworks | Auto subnet mode | `false` |
| enable_private_service_access | Reserve range and peer for Private Service Access | `false` |
| private_service_access_address | First IP of PSA range (empty = GCP picks) | `""` |
| private_service_access_prefix_length | PSA range prefix length | `16` |

## Outputs

- `network_name`, `network_id`, `network_self_link`, `subnets`, `subnet_self_links`, `route_names`
- `private_service_access_reserved_range_name`, `private_service_access_address` (when PSA enabled)