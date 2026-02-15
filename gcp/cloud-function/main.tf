/**
 * Cloud Function only: zip source, upload to caller-provided bucket (from cloud-storage module),
 * deploy function. No bucket creation — use cloud-storage for the bucket.
 */

data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_directory
  output_path = "${path.module}/.zip/${var.name}.zip"
  excludes    = var.files_to_exclude
}

resource "google_storage_bucket_object" "archive" {
  name          = "${var.name}-${data.archive_file.source.output_md5}.zip"
  bucket        = var.bucket_name
  source        = data.archive_file.source.output_path
  content_type  = "application/zip"
}

resource "google_cloudfunctions_function" "function" {
  project               = var.project_id
  name                  = var.name
  region                = var.region
  runtime               = var.runtime
  entry_point           = var.entry_point
  available_memory_mb    = var.available_memory_mb
  timeout               = var.timeout_s
  source_archive_bucket  = var.bucket_name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = var.trigger_http
  labels                = var.labels
  description           = var.description
  environment_variables = var.environment_variables

  dynamic "event_trigger" {
    for_each = var.trigger_http ? [] : [var.event_trigger]
    content {
      event_type = event_trigger.value.event_type
      resource   = event_trigger.value.resource
      failure_policy {
        retry = try(var.event_trigger_failure_retry, false)
      }
    }
  }
}
