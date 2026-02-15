/**
 * Standalone Data Fusion module: one instance (public or private).
 * Only google_data_fusion_instance—no module calls.
 */

resource "google_data_fusion_instance" "instance" {
  provider = google-beta

  project                       = var.project_id
  name                          = var.name
  region                        = var.region
  type                          = var.type
  description                   = var.description
  labels                        = var.labels
  version                       = var.datafusion_version
  options                       = var.options
  enable_stackdriver_logging    = var.enable_stackdriver_logging
  enable_stackdriver_monitoring = var.enable_stackdriver_monitoring
  private_instance              = var.network_config != null

  dynamic "network_config" {
    for_each = var.network_config != null ? [var.network_config] : []
    content {
      network       = network_config.value.network
      ip_allocation = network_config.value.ip_allocation
    }
  }
}
