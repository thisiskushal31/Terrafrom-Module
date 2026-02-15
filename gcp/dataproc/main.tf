/**
 * Standalone Dataproc cluster. Master and optional workers.
 * Only google_* — no module calls.
 */

resource "google_dataproc_cluster" "cluster" {
  project  = var.project_id
  name     = var.name
  region   = var.region
  labels   = var.labels
  cluster_config {
    staging_bucket = var.staging_bucket
    dynamic "master_config" {
      for_each = var.master_num_instances >= 1 ? [1] : []
      content {
        num_instances = var.master_num_instances
        machine_type  = var.master_machine_type
        disk_config {
          boot_disk_type    = var.master_boot_disk_type
          boot_disk_size_gb = var.master_boot_disk_size_gb
        }
      }
    }
    dynamic "worker_config" {
      for_each = var.worker_num_instances >= 1 ? [1] : []
      content {
        num_instances = var.worker_num_instances
        machine_type  = var.worker_machine_type
        disk_config {
          boot_disk_type    = var.worker_boot_disk_type
          boot_disk_size_gb = var.worker_boot_disk_size_gb
        }
      }
    }
    dynamic "software_config" {
      for_each = length(var.override_properties) > 0 ? [1] : []
      content {
        override_properties = var.override_properties
      }
    }
  }
}
