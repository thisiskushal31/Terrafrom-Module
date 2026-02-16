# Redis Enterprise on AWS (Redis Cloud)

Creates a **Redis Enterprise** deployment on **AWS** using [Redis Cloud](https://redis.io/redis-enterprise-cloud/) (Redis Inc.): one **subscription** (Pro) and one **database** within it. Uses the [RedisLabs/rediscloud](https://registry.terraform.io/providers/RedisLabs/rediscloud/latest) Terraform provider.

## Scope

- **Subscription** – Redis Cloud Pro subscription in AWS (region, CIDR, AZs).
- **Database** – One Redis database in that subscription (dataset size, throughput, persistence).

## Prerequisites

- Redis Cloud account; API enabled; credentials as `REDISCLOUD_ACCESS_KEY` and `REDISCLOUD_SECRET_KEY`.
- Payment method set (or pass `payment_method_id`).

## Usage

```hcl
module "redis_enterprise" {
  source = "./redis-enterprise/aws"

  subscription_name = "my-redis-enterprise"
  database_name     = "my-db"

  payment_method_id = data.rediscloud_payment_method.card.id  # or omit if using marketplace

  region                     = "us-east-1"
  networking_deployment_cidr = "10.0.0.0/24"
  preferred_availability_zones = ["use1-az1", "use1-az2", "use1-az5"]

  dataset_size_in_gb         = 5
  throughput_measurement_value = 10000
  data_persistence           = "aof-every-write"
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| subscription_name | Subscription name | required |
| database_name | Database name | required |
| payment_method | credit-card or marketplace | credit-card |
| payment_method_id | Payment method ID (for credit-card) | null |
| cloud_account_id | Redis Cloud account ID | null (1) |
| region | AWS region | required |
| multiple_availability_zones | Use multiple AZs | true |
| networking_deployment_cidr | /24 CIDR for deployment | required |
| preferred_availability_zones | AZ list (e.g. use1-az1, use1-az2, use1-az5) | [] |
| dataset_size_in_gb | Dataset size (GB) | required |
| creation_plan_quantity | Number of DBs in creation plan | 1 |
| replication | Enable replication | true |
| throughput_measurement_by | operations-per-second or number-of-shards | operations-per-second |
| throughput_measurement_value | Throughput value | 20000 |
| data_persistence | Persistence mode | none |
| public_endpoint_access | Allow public DB access | false |
| tags | Database tags (lowercase) | {} |

## Outputs

| Name | Description |
|------|-------------|
| subscription_id | Redis Cloud subscription ID |
| database_id | Redis Cloud database ID |
| public_endpoint | Public connection endpoint |
| private_endpoint | Private connection endpoint |
