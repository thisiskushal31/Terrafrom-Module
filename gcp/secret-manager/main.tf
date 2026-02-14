/**
 * Standalone Secret Manager module: secrets + optional first version.
 * Only google_secret_manager_* resources—no module calls.
 */

resource "google_secret_manager_secret" "secret" {
  for_each = var.secrets

  project   = var.project_id
  secret_id = each.key

  labels = try(each.value.labels, {})
  dynamic "replication" {
    for_each = try(each.value.replication_locations, null) != null ? [1] : []
    content {
      user_managed {
        dynamic "replicas" {
          for_each = each.value.replication_locations
          content {
            location = replicas.value
          }
        }
      }
    }
  }
  dynamic "replication" {
    for_each = try(each.value.replication_locations, null) == null ? [1] : []
    content {
      auto {}
    }
  }

  deletion_protection = try(each.value.deletion_protection, false)
}

resource "google_secret_manager_secret_version" "version" {
  for_each = { for k, v in var.secrets : k => v if try(v.secret_data, null) != null }

  secret      = google_secret_manager_secret.secret[each.key].id
  secret_data = each.value.secret_data
}
