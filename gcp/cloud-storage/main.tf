/**
 * Standalone module: GCS buckets with optional versioning and labels.
 * Only google_storage_bucket (and optional random_id)—no module calls.
 */

locals {
  names_set = toset(var.names)
  suffix    = var.randomize_suffix ? "-${random_id.bucket_suffix[0].hex}" : ""
}

resource "random_id" "bucket_suffix" {
  count       = var.randomize_suffix ? 1 : 0
  byte_length = 2
}

resource "google_storage_bucket" "buckets" {
  for_each = local.names_set

  name     = "${var.prefix}${each.value}${local.suffix}"
  project  = var.project_id
  location = var.location

  storage_class               = var.storage_class
  labels                      = merge(var.labels, { name = replace(each.value, ".", "-") })
  force_destroy               = try(var.force_destroy[lower(each.value)], false)
  uniform_bucket_level_access  = try(var.uniform_bucket_level_access[lower(each.value)], true)
  public_access_prevention    = var.public_access_prevention

  versioning {
    enabled = try(var.versioning[lower(each.value)], false)
  }
}
