/**
 * Standalone module: Cloud NAT and optional Cloud Router.
 * Only google_compute_router and google_compute_router_nat—no module calls.
 */

resource "google_compute_router" "router" {
  count = var.create_router ? 1 : 0

  project = var.project_id
  name    = var.router
  region  = var.region
  network = var.network

  dynamic "bgp" {
    for_each = var.router_asn != null ? [1] : []
    content {
      asn                 = var.router_asn
      keepalive_interval  = try(var.router_keepalive_interval, 20)
    }
  }
}

locals {
  router_name = var.create_router ? google_compute_router.router[0].name : var.router
}

resource "google_compute_router_nat" "nat" {
  project  = var.project_id
  region   = var.region
  name     = var.name != "" ? var.name : "cloud-nat-${var.router}"
  router   = local.router_name
  nat_ip_allocate_option = length(var.nat_ips) > 0 ? "MANUAL_ONLY" : "AUTO_ONLY"
  nat_ips  = var.nat_ips

  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  min_ports_per_vm                   = var.min_ports_per_vm

  dynamic "subnetwork" {
    for_each = var.subnetworks
    content {
      name                    = subnetwork.value.name
      source_ip_ranges_to_nat = subnetwork.value.source_ip_ranges_to_nat
      secondary_ip_range_names = try(subnetwork.value.secondary_ip_range_names, [])
    }
  }

  dynamic "log_config" {
    for_each = var.log_config_enable ? [1] : []
    content {
      enable = true
      filter = var.log_config_filter
    }
  }
}
