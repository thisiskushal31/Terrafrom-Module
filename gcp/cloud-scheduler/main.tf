/**
 * Standalone Cloud Scheduler job: HTTP target or Pub/Sub target.
 * Only google_* — no module calls.
 */

resource "google_cloud_scheduler_job" "job" {
  project     = var.project_id
  name        = var.name
  region      = var.region
  description = var.description
  schedule    = var.schedule
  time_zone   = var.time_zone
  attempt_deadline = var.attempt_deadline
  paused      = var.paused

  dynamic "retry_config" {
    for_each = var.retry_count != null ? [1] : []
    content {
      retry_count = var.retry_count
    }
  }

  dynamic "http_target" {
    for_each = var.target_type == "http" ? [1] : []
    content {
      uri         = var.http_uri
      http_method = var.http_method
      body        = var.http_body != null ? base64encode(var.http_body) : null
      headers     = var.http_headers

      dynamic "oidc_token" {
        for_each = var.oidc_service_account_email != null && var.oidc_service_account_email != "" ? [1] : []
        content {
          service_account_email = var.oidc_service_account_email
        }
      }
    }
  }

  dynamic "pubsub_target" {
    for_each = var.target_type == "pubsub" ? [1] : []
    content {
      topic_name = var.pubsub_topic_name
      data       = var.pubsub_data != null ? base64encode(var.pubsub_data) : null
    }
  }
}
