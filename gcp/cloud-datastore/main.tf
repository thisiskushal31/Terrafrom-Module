/**
 * Standalone Cloud Datastore module: composite indexes.
 * Only google_datastore_index resources—no module calls.
 */

resource "google_datastore_index" "index" {
  for_each = { for i, idx in var.indexes : try(idx.id, "index-${i}") => idx }

  project = var.project_id
  kind    = each.value.kind
  ancestor = try(each.value.ancestor, "NONE")

  dynamic "properties" {
    for_each = each.value.properties
    content {
      name      = properties.value.name
      direction = properties.value.direction
    }
  }
}
