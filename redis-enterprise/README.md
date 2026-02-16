# Redis Enterprise (Redis Cloud) modules

Standalone Terraform modules for **Redis Enterprise** via [Redis Cloud](https://redis.io/redis-enterprise-cloud/) (Redis Inc.). Each subfolder deploys one **subscription** (Pro) and one **database** in a specific cloud. Uses the [RedisLabs/rediscloud](https://registry.terraform.io/providers/RedisLabs/rediscloud/latest) provider.

**Prerequisites:** Redis Cloud account, API enabled, `REDISCLOUD_ACCESS_KEY` and `REDISCLOUD_SECRET_KEY`, and a payment method (or `payment_method_id`).

---

## What's here

| Module   | Cloud | What it does |
|----------|--------|---------------|
| **aws**  | AWS   | Redis Cloud Pro subscription + database in an AWS region |
| **azure**| Azure | Redis Cloud Pro subscription + database in an Azure region |
| **gcp**  | GCP   | Redis Cloud Pro subscription + database in a GCP region |

Each module has `versions.tf`, `main.tf`, `variables.tf`, `outputs.tf`, and a `README.md`. No cross-module or cloud-provider (aws/azurerm/google) resources; only the Redis Cloud provider is used.

---

## How to use

From your Terraform root, add the Redis Cloud provider and call the module for the cloud you want:

```hcl
terraform {
  required_providers {
    rediscloud = { source = "RedisLabs/rediscloud", version = ">= 1.0" }
  }
}

module "redis_enterprise" {
  source = "./redis-enterprise/aws"   # or redis-enterprise/azure, redis-enterprise/gcp

  subscription_name = "my-redis"
  database_name     = "my-db"
  payment_method_id = data.rediscloud_payment_method.card.id

  region                     = "us-east-1"
  networking_deployment_cidr = "10.0.0.0/24"
  preferred_availability_zones = ["use1-az1", "use1-az2", "use1-az5"]

  dataset_size_in_gb = 5
}
```

See **[aws/README.md](aws/README.md)** for full inputs and outputs; **[azure/README.md](azure/README.md)** and **[gcp/README.md](gcp/README.md)** for cloud-specific usage.
