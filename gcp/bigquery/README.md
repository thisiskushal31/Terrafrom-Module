# bigquery

Standalone module: **BigQuery** dataset, tables, views. Only GCP resources here—no external module calls.

## Usage

```hcl
module "bigquery" {
  source  = "./gcp/bigquery"
  project_id   = var.project_id
  dataset_id   = "analytics"
  dataset_name = "Analytics"
  location     = "US"
  default_table_expiration_ms = 86400000
  tables = [
    { table_id = "events", schema = [{ name = "id", type = "STRING" }, { name = "ts", type = "TIMESTAMP" }] },
  ]
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| project_id | Project ID | required |
| dataset_id | Dataset ID | required |
| dataset_name | Friendly name | dataset_id |
| location | Location | `"US"` |
| default_table_expiration_ms | Table TTL (ms) | null |
| tables | Table definitions (table_id, schema, time_partitioning, clustering) | `[]` |
| views | View definitions (view_id, query) | `[]` |

## Outputs

- `dataset_id`, `dataset`, `tables`, `views`
