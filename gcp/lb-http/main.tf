/**
 * Standalone global HTTP(S) load balancer: address, backend service, health check, URL map, proxy, forwarding rule.
 * Only google_compute_* resources—no module calls. Optional SSL (pass existing certs).
 */

locals {
  address = var.create_address ? google_compute_global_address.default[0].address : var.address
}

resource "google_compute_global_address" "default" {
  count     = var.create_address ? 1 : 0
  project   = var.project_id
  name      = "${var.name}-address"
  ip_version = "IPV4"
  labels    = var.labels
}

resource "google_compute_health_check" "default" {
  project = var.project_id
  name    = "${var.name}-health-check"

  check_interval_sec  = var.health_check_interval_sec
  timeout_sec         = var.health_check_timeout_sec
  healthy_threshold   = var.health_check_healthy_threshold
  unhealthy_threshold = var.health_check_unhealthy_threshold

  http_health_check {
    port         = var.health_check_port
    request_path = var.health_check_path
  }
}

resource "google_compute_backend_service" "default" {
  project   = var.project_id
  name      = "${var.name}-backend"
  port_name = var.backend_port_name
  protocol  = "HTTP"

  timeout_sec = var.backend_timeout_sec
  enable_cdn  = var.enable_cdn

  health_checks = [google_compute_health_check.default.id]

  dynamic "backend" {
    for_each = var.backend_groups
    content {
      group           = backend.value
      balancing_mode  = "UTILIZATION"
      max_utilization = try(var.backend_max_utilization, 0.8)
    }
  }
}

resource "google_compute_url_map" "default" {
  project         = var.project_id
  name            = "${var.name}-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_http_proxy" "default" {
  count   = var.ssl_certificate_self_links == null || length(var.ssl_certificate_self_links) == 0 ? 1 : 0
  project = var.project_id
  name    = "${var.name}-http-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_target_https_proxy" "default" {
  count            = var.ssl_certificate_self_links != null && length(var.ssl_certificate_self_links) > 0 ? 1 : 0
  project          = var.project_id
  name             = "${var.name}-https-proxy"
  url_map          = google_compute_url_map.default.id
  ssl_certificates = var.ssl_certificate_self_links
}

resource "google_compute_global_forwarding_rule" "http" {
  count      = var.ssl_certificate_self_links == null || length(var.ssl_certificate_self_links) == 0 ? 1 : 0
  project    = var.project_id
  name       = var.name
  target     = google_compute_target_http_proxy.default[0].id
  ip_address = local.address
  port_range = var.http_port_range
  labels     = var.labels
}

resource "google_compute_global_forwarding_rule" "https" {
  count      = var.ssl_certificate_self_links != null && length(var.ssl_certificate_self_links) > 0 ? 1 : 0
  project    = var.project_id
  name       = "${var.name}-https"
  target     = google_compute_target_https_proxy.default[0].id
  ip_address = local.address
  port_range = var.https_port_range
  labels     = var.labels
}
