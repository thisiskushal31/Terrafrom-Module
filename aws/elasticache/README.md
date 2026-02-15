# elasticache

Creates an ElastiCache Redis replication group (and optional subnet group). Use for caching, session store, pub/sub.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| replication_group_id | Group identifier | required |
| node_type | e.g. cache.t3.micro | required |
| num_cache_clusters | Number of nodes | 1 |
| subnet_ids | Subnets for subnet group | required |
| security_group_ids | Security groups | required |
| engine_version | Redis version | null |
| tags | Tags | {} |

## Outputs

- **replication_group_id**, **primary_endpoint_address**, **reader_endpoint_address**, **port**
