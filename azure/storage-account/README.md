# storage-account

Creates an Azure Storage Account and optional blob containers. Use for object storage (counterpart to S3/GCS). Resource group from caller.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| storage_account_name | 3-24 alphanumeric | required |
| resource_group_name, location | Required | — |
| account_tier | Standard or Premium | Standard |
| account_replication_type | LRS, GRS, ZRS, etc. | LRS |
| containers | List of container names | [] |
| tags | Tags | {} |

## Outputs

- **storage_account_id**, **storage_account_name**, **primary_blob_endpoint**, **primary_connection_string** (sensitive)
