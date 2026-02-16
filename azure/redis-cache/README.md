# Azure Cache for Redis

Creates an **Azure Cache for Redis** instance (Azure’s managed Redis). Equivalent to AWS ElastiCache for Redis and GCP Memorystore for Redis.

## Scope

- Single `azurerm_redis_cache`: Basic, Standard, or Premium SKU.
- Optional VNet integration (Premium) via `subnet_id`.

## Usage

```hcl
module "redis_cache" {
  source = "./azure/redis-cache"

  name                = "my-redis-cache"
  resource_group_name = azurerm_resource_group.this.name
  location            = "eastus"
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"

  minimum_tls_version = "1.2"
  tags                = { env = "prod" }
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | Cache name (globally unique) | required |
| resource_group_name | Resource group | required |
| location | Azure region | required |
| capacity | Size (C: 0–6, P: 1–4) | required |
| family | C or P | required |
| sku_name | Basic, Standard, Premium | required |
| enable_non_ssl_port | Allow port 6379 | false |
| minimum_tls_version | 1.0, 1.1, 1.2 | 1.2 |
| subnet_id | Subnet (Premium VNet) | null |
| private_static_ip_address | Static IP (Premium) | null |
| redis_configuration | Redis config map | {} |
| tags | Tags | {} |

## Outputs

| Name | Description |
|------|-------------|
| id | Resource ID |
| hostname | Redis hostname |
| port | Port |
| ssl_port | SSL port |
| primary_access_key | Primary key (sensitive) |
| secondary_access_key | Secondary key (sensitive) |
