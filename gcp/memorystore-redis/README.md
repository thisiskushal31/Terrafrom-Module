# Memorystore for Redis (GCP)

Creates a **Memorystore for Redis** instance (GCP’s managed Redis). Equivalent to AWS ElastiCache for Redis and Azure Cache for Redis.

## Scope

- Single `google_redis_instance`: BASIC (single zone) or STANDARD_HA (replica in two zones).
- Optional VPC attachment via `authorized_network` and optional `reserved_ip_range`.

## Usage

```hcl
module "memorystore_redis" {
  source = "./gcp/memorystore-redis"

  name           = "my-redis"
  project_id     = var.project_id
  tier           = "STANDARD_HA"
  memory_size_gb = 1
  region         = "us-central1"
  location_id    = "us-central1-a"
  alternative_location_id = "us-central1-f"

  authorized_network = module.network.network_self_link
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | Instance name | required |
| project_id | GCP project ID | required |
| tier | BASIC or STANDARD_HA | BASIC |
| memory_size_gb | Memory size (GB) | required |
| region | GCP region | required |
| location_id | Zone (BASIC) | null |
| alternative_location_id | Second zone (STANDARD_HA) | null |
| authorized_network | VPC network for private Redis | null |
| redis_version | Redis version | null |
| display_name | Display name | null |
| labels | Labels | {} |
| reserved_ip_range | CIDR for instance | null |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | Instance ID |
| host | Host IP |
| port | Port |
| current_location_id | Current zone |
