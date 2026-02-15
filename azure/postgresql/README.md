# postgresql

Creates an Azure PostgreSQL Flexible Server and optional databases. Use for relational DB (counterpart to RDS/Cloud SQL). Resource group from caller; optional delegated subnet for private access.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| server_name, resource_group_name, location | Required | — |
| administrator_login, administrator_password | Admin credentials | required |
| postgres_version | 14, 15, 16 | 16 |
| sku_name | e.g. GP_Standard_D2s_v3 | GP_Standard_D2s_v3 |
| storage_mb | Storage size | 32768 |
| databases | List of DB names to create | [] |
| delegated_subnet_id, private_dns_zone_id | For private access | null |
| tags | Tags | {} |

## Outputs

- **server_id**, **fqdn**, **server_name**
