/**
 * Network module: full VPC surface. Only google_compute_* and google_service_networking_connection—no module calls.
 * - VPC (create, routing mode, MTU)
 * - Subnets (secondary ranges, private access, flow logs)
 * - Routes (gateway, IP, instance, VPC peering, internal LB)
 * - Firewall ingress/egress (allow/deny, tags, service accounts, log_config, disabled)
 * - VPC peering (export/import custom and subnet routes)
 * - Private Service Access (reserved range + service networking connection)
 */

resource "google_compute_network" "vpc" {
  project                 = var.project_id
  name                    = var.network_name
  description             = var.description
  routing_mode            = var.routing_mode
  auto_create_subnetworks = var.auto_create_subnetworks
  mtu                     = var.mtu > 0 ? var.mtu : null
}

resource "google_compute_subnetwork" "subnets" {
  for_each = { for i, s in var.subnets : s.subnet_name => s }

  project       = var.project_id
  name          = each.value.subnet_name
  ip_cidr_range = each.value.subnet_ip
  region        = each.value.subnet_region
  network       = google_compute_network.vpc.id
  description   = try(each.value.description, null)
  private_ip_google_access = try(each.value.subnet_private_access, false) ? true : null

  dynamic "secondary_ip_range" {
    for_each = try(var.secondary_ranges[each.value.subnet_name], [])
    content {
      range_name    = secondary_ip_range.value.range_name
      ip_cidr_range = secondary_ip_range.value.ip_cidr_range
    }
  }

  dynamic "log_config" {
    for_each = try(var.subnet_flow_logs[each.value.subnet_name], null) != null ? [var.subnet_flow_logs[each.value.subnet_name]] : []
    content {
      aggregation_interval = try(log_config.value.aggregation_interval, "INTERVAL_5_SEC")
      flow_sampling        = try(log_config.value.flow_sampling, 0.5)
      metadata             = try(log_config.value.metadata, "INCLUDE_ALL_METADATA")
    }
  }
}

resource "google_compute_route" "routes" {
  for_each = { for i, r in var.routes : "${r.name}-${i}" => r }

  project  = var.project_id
  name     = each.value.name
  network  = google_compute_network.vpc.name
  dest_range = each.value.dest_range
  next_hop_gateway     = try(each.value.next_hop_gateway, null)
  next_hop_ip          = try(each.value.next_hop_ip, null)
  next_hop_instance    = try(each.value.next_hop_instance, null)
  next_hop_vpc_peering = try(each.value.next_hop_vpc_peering, null)
  next_hop_ilb         = try(each.value.next_hop_ilb, null)
  priority             = try(each.value.priority, 1000)
}

resource "google_compute_firewall" "ingress" {
  for_each = { for i, r in var.ingress_rules : "${r.name}-${i}" => r }

  project = var.project_id
  name    = each.value.name
  network = google_compute_network.vpc.name
  direction = "INGRESS"
  priority  = try(each.value.priority, 1000)
  description = try(each.value.description, null)

  source_ranges            = try(each.value.source_ranges, [])
  source_tags              = try(each.value.source_tags, null)
  source_service_accounts  = try(each.value.source_service_accounts, null)
  target_tags              = try(each.value.target_tags, null)
  target_service_accounts  = try(each.value.target_service_accounts, null)
  disabled                 = try(each.value.disabled, false)

  dynamic "log_config" {
    for_each = try(each.value.log_config, null) != null ? [each.value.log_config] : []
    content {
      metadata = log_config.value.metadata
      filter   = try(log_config.value.filter, null)
    }
  }

  dynamic "allow" {
    for_each = try(each.value.allow, [])
    content {
      protocol = allow.value.protocol
      ports    = try(allow.value.ports, null)
    }
  }
  dynamic "deny" {
    for_each = try(each.value.deny, [])
    content {
      protocol = deny.value.protocol
      ports    = try(deny.value.ports, null)
    }
  }
}

resource "google_compute_firewall" "egress" {
  for_each = { for i, r in var.egress_rules : "${r.name}-${i}" => r }

  project = var.project_id
  name    = each.value.name
  network = google_compute_network.vpc.name
  direction = "EGRESS"
  priority  = try(each.value.priority, 1000)
  description = try(each.value.description, null)

  destination_ranges     = try(each.value.destination_ranges, [])
  target_tags             = try(each.value.target_tags, null)
  target_service_accounts = try(each.value.target_service_accounts, null)
  disabled                = try(each.value.disabled, false)

  dynamic "log_config" {
    for_each = try(each.value.log_config, null) != null ? [each.value.log_config] : []
    content {
      metadata = log_config.value.metadata
      filter   = try(log_config.value.filter, null)
    }
  }

  dynamic "allow" {
    for_each = try(each.value.allow, [])
    content {
      protocol = allow.value.protocol
      ports    = try(allow.value.ports, null)
    }
  }
  dynamic "deny" {
    for_each = try(each.value.deny, [])
    content {
      protocol = deny.value.protocol
      ports    = try(deny.value.ports, null)
    }
  }
}

# VPC peering (peer this VPC with another network)
resource "google_compute_network_peering" "peering" {
  for_each = { for i, p in var.peerings : "${p.name}-${i}" => p }

  name         = each.value.name
  network      = google_compute_network.vpc.self_link
  peer_network = each.value.peer_network
  export_custom_routes    = try(each.value.export_custom_routes, false)
  import_custom_routes    = try(each.value.import_custom_routes, false)
  export_subnet_routes_with_public_ip = try(each.value.export_subnet_routes_with_public_ip, false)
  import_subnet_routes_with_public_ip = try(each.value.import_subnet_routes_with_public_ip, false)
}

# Private Service Access (optional): VPC peering for Cloud SQL private IP, etc.
# https://cloud.google.com/vpc/docs/configure-private-services-access
resource "google_compute_global_address" "private_service_access_range" {
  count = var.enable_private_service_access ? 1 : 0

  provider      = google-beta
  project       = var.project_id
  name          = "google-managed-services-${var.network_name}"
  description   = var.private_service_access_description
  purpose       = "VPC_PEERING"
  address       = var.private_service_access_address != "" ? var.private_service_access_address : null
  prefix_length = var.private_service_access_prefix_length
  address_type  = "INTERNAL"
  network       = google_compute_network.vpc.self_link
  labels        = var.private_service_access_labels
}

resource "google_service_networking_connection" "private_service_access" {
  count = var.enable_private_service_access ? 1 : 0

  provider                = google-beta
  network                 = google_compute_network.vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_service_access_range[0].name]
}
