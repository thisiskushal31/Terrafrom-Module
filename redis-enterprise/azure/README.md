# Redis Enterprise on Azure (Redis Cloud)

Creates a **Redis Enterprise** deployment on **Azure** using [Redis Cloud](https://redis.io/redis-enterprise-cloud/): one **subscription** (Pro) and one **database** within it. Uses the [RedisLabs/rediscloud](https://registry.terraform.io/providers/RedisLabs/rediscloud/latest) Terraform provider.

## Scope

- **Subscription** – Redis Cloud Pro subscription in Azure (region, CIDR, AZs).
- **Database** – One Redis database in that subscription (dataset size, throughput, persistence).

## Prerequisites

- Redis Cloud account; API enabled; credentials as `REDISCLOUD_ACCESS_KEY` and `REDISCLOUD_SECRET_KEY`.
- Payment method set (or pass `payment_method_id`).
- Confirm [Redis Cloud Terraform provider](https://registry.terraform.io/providers/RedisLabs/rediscloud/latest) supports `provider = "AZURE"` for your provider version.

## Usage

```hcl
module "redis_enterprise" {
  source = "./redis-enterprise/azure"

  subscription_name = "my-redis-enterprise"
  database_name     = "my-db"

  payment_method_id = data.rediscloud_payment_method.card.id

  region                    = "eastus"
  networking_deployment_cidr = "10.0.0.0/24"
  preferred_availability_zones = []  # set per Redis Cloud Azure docs if required

  dataset_size_in_gb          = 5
  throughput_measurement_value = 10000
  data_persistence            = "aof-every-write"
}
```

## Inputs / Outputs

See [../README.md](../README.md) and [aws/README.md](../aws/README.md) for the same variable and output list; only `region` and cloud-specific options (e.g. preferred_availability_zones) differ for Azure.
