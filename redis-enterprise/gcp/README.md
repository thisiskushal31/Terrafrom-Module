# Redis Enterprise on GCP (Redis Cloud)

Creates a **Redis Enterprise** deployment on **GCP** using [Redis Cloud](https://redis.io/redis-enterprise-cloud/): one **subscription** (Pro) and one **database** within it. Uses the [RedisLabs/rediscloud](https://registry.terraform.io/providers/RedisLabs/rediscloud/latest) Terraform provider.

## Scope

- **Subscription** – Redis Cloud Pro subscription in GCP (region, CIDR, AZs).
- **Database** – One Redis database in that subscription (dataset size, throughput, persistence).

## Prerequisites

- Redis Cloud account; API enabled; credentials as `REDISCLOUD_ACCESS_KEY` and `REDISCLOUD_SECRET_KEY`.
- Payment method set (or pass `payment_method_id`).
- GCP subscriptions typically use Redis Labs internal cloud account (cloud_account_id = 1).

## Usage

```hcl
module "redis_enterprise" {
  source = "./redis-enterprise/gcp"

  subscription_name = "my-redis-enterprise"
  database_name     = "my-db"

  payment_method_id = data.rediscloud_payment_method.card.id

  region                     = "us-central1"
  networking_deployment_cidr = "10.0.0.0/24"
  preferred_availability_zones = ["us-central1-a", "us-central1-b", "us-central1-f"]

  dataset_size_in_gb          = 5
  throughput_measurement_value = 10000
  data_persistence            = "aof-every-write"
}
```

## Inputs / Outputs

Same as [aws/README.md](../aws/README.md); only `region` and `preferred_availability_zones` (GCP zone IDs) differ.
