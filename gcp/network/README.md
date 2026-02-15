# network

Single module for **all VPC/network** resources: one place for the full network surface.

## What this module covers

| Area | Resources / behaviour |
|------|------------------------|
| **VPC** | Create VPC: name, routing mode (GLOBAL/REGIONAL), auto_create_subnetworks, MTU, description |
| **Subnets** | Create subnets: CIDR, region, secondary ranges, private Google access, **flow logs** (optional per subnet) |
| **Routes** | Custom routes: next-hop gateway, IP, instance, **VPC peering**, **internal LB** (`next_hop_ilb`), priority |
| **Firewall** | **Ingress** and **egress** rules: allow/deny, source/destination ranges, **source/target tags**, **source/target service accounts**, **log_config** (metadata/filter), **disabled** flag, priority |
| **VPC peering** | Peer this VPC with other networks: export/import custom routes, export/import subnet routes with public IP |
| **Private Service Access** | Reserve range and create service networking connection (e.g. for Cloud SQL private IP) |

So: **VPC → subnets → routes → firewall (ingress/egress, with tags, SAs, logging) → peering → PSA** are all handled here.

**Multiple of each:** You can create as many subnets, routes, ingress rules, egress rules, and peerings as you need — pass multiple entries in `subnets`, `routes`, `ingress_rules`, `egress_rules`, and `peerings`. One module instance = one VPC; for multiple VPCs, use multiple module instances.

**Delete anytime:** To remove a subnet, route, firewall rule, or peering, delete that entry from the corresponding variable and run `terraform apply` — Terraform will destroy that resource. Same for turning off PSA (`enable_private_service_access = false` and apply).

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
  subnet_flow_logs = {
    "subnet-01" = { aggregation_interval = "INTERVAL_5_SEC", flow_sampling = 0.5, metadata = "INCLUDE_ALL_METADATA" }
  }
  ingress_rules = [
    { name = "allow-ssh", source_ranges = ["0.0.0.0/0"], allow = [{ protocol = "tcp", ports = ["22"] }] },
    { name = "allow-sa", target_service_accounts = ["my-sa@project.iam.gserviceaccount.com"], allow = [{ protocol = "tcp", ports = ["443"] }], log_config = { metadata = "INCLUDE_ALL_METADATA" } },
  ]
  routes = [
    { name = "default-via-ilb", dest_range = "0.0.0.0/0", next_hop_ilb = "https://www.googleapis.com/compute/v1/projects/.../regions/.../backendServices/..." },
  ]
  peerings = [
    { name = "peer-to-other", peer_network = "projects/other-project/global/networks/other-vpc", export_custom_routes = true, import_custom_routes = true },
  ]
  enable_private_service_access = true
  private_service_access_prefix_length = 16
}
```

## Inputs

See `variables.tf`. Main ones: `project_id`, `network_name`, `subnets`, `secondary_ranges`, `routes` (incl. `next_hop_ilb`), `ingress_rules` / `egress_rules` (incl. `source_service_accounts`, `target_service_accounts`, `log_config`, `disabled`), `peerings`, `subnet_flow_logs`, `enable_private_service_access`, PSA address/prefix/labels.

## Outputs

`network_name`, `network_id`, `network_self_link`, `subnets`, `subnet_self_links`, `route_names`, `peering_names`, `private_service_access_*`, `private_subnets`, `private_subnets_map`, `secondary_ranges_by_subnet`, `gcp_cloud`, `region`.
