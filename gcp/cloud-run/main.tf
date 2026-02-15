/**
 * Standalone Cloud Run service (Gen 2). One service with container image and scaling.
 * Only google_* — no module calls.
 */

resource "google_cloud_run_v2_service" "service" {
  project     = var.project_id
  name        = var.name
  location    = var.region
  description = var.description
  labels      = var.labels
  deletion_protection = var.deletion_protection

  template {
    scaling {
      min_instance_count = var.min_instances
      max_instance_count = var.max_instances
    }

    containers {
      image = var.image

      dynamic "env" {
        for_each = var.env
        content {
          name  = env.key
          value = env.value
        }
      }

      resources {
        limits = {
          cpu    = var.cpu_limit
          memory = var.memory_limit
        }
      }
    }
  }
}
