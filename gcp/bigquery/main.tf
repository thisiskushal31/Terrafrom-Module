/**
 * Standalone module: BigQuery dataset, tables, views.
 * Only google_bigquery_dataset and google_bigquery_table—no module calls.
 */

resource "google_bigquery_dataset" "dataset" {
  project    = var.project_id
  dataset_id = var.dataset_id
  friendly_name = coalesce(var.dataset_name, var.dataset_id)
  description   = var.description
  location      = var.location

  default_table_expiration_ms = var.default_table_expiration_ms
  delete_contents_on_destroy  = var.delete_contents_on_destroy

  labels = var.dataset_labels
}

resource "google_bigquery_table" "tables" {
  for_each = { for t in var.tables : t.table_id => t }

  dataset_id = google_bigquery_dataset.dataset.dataset_id
  project    = var.project_id
  table_id   = each.value.table_id
  description = try(each.value.description, null)
  expiration_time = try(each.value.expiration_time, null)
  labels     = try(each.value.labels, null)

  dynamic "schema" {
    for_each = try(each.value.schema, null) != null ? [1] : []
    content {
      dynamic "field" {
        for_each = each.value.schema
        content {
          name        = field.value.name
          type        = field.value.type
          mode        = try(field.value.mode, null)
          description = try(field.value.description, null)
        }
      }
    }
  }

  dynamic "time_partitioning" {
    for_each = try(each.value.time_partitioning, null) != null ? [each.value.time_partitioning] : []
    content {
      type                     = time_partitioning.value.type
      field                    = try(time_partitioning.value.field, null)
      require_partition_filter = try(time_partitioning.value.require_partition_filter, false)
      expiration_ms            = try(time_partitioning.value.expiration_ms, null)
    }
  }

  clustering = try(each.value.clustering, null)
}

resource "google_bigquery_table" "views" {
  for_each = { for v in var.views : v.view_id => v }

  dataset_id  = google_bigquery_dataset.dataset.dataset_id
  project     = var.project_id
  table_id    = each.value.view_id
  description = try(each.value.description, null)
  labels      = try(each.value.labels, null)

  view {
    query = each.value.query
    use_legacy_sql = try(each.value.use_legacy_sql, false)
  }
}
