# redshift

Creates a Redshift cluster and optional subnet group. Use for data warehouse / analytics.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| cluster_identifier | Cluster ID | required |
| node_type | e.g. dc2.large | required |
| number_of_nodes | Node count | 1 |
| master_username, master_password | Admin credentials | required |
| subnet_ids, security_group_ids | From caller | required |
| skip_final_snapshot | Skip snapshot on delete | true |
| tags | Tags | {} |

## Outputs

- **cluster_id**, **cluster_endpoint**, **cluster_arn**
