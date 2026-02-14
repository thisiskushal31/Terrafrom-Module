output "network_name" {
  description = "VPC name"
  value       = google_compute_network.vpc.name
}

output "network_id" {
  description = "VPC ID"
  value       = google_compute_network.vpc.id
}

output "network_self_link" {
  description = "VPC self link"
  value       = google_compute_network.vpc.self_link
}

output "subnets" {
  description = "Subnet resources (key = subnet name)"
  value       = google_compute_subnetwork.subnets
}

output "subnet_self_links" {
  description = "Subnet self links by name"
  value       = { for k, v in google_compute_subnetwork.subnets : k => v.self_link }
}

output "route_names" {
  description = "Created route names"
  value       = [for r in google_compute_route.routes : r.name]
}

# Private Service Access (when enable_private_service_access = true)
output "private_service_access_reserved_range_name" {
  description = "Name of the reserved range for Private Service Access"
  value       = var.enable_private_service_access ? google_compute_global_address.private_service_access_range[0].name : null
}

output "private_service_access_address" {
  description = "First IP of the reserved range for Private Service Access"
  value       = var.enable_private_service_access ? google_compute_global_address.private_service_access_range[0].address : null
}

# Additional outputs for GKE and other consumers
output "vpc_id" {
  description = "VPC ID (alias for network_id)"
  value       = google_compute_network.vpc.id
}

output "private_subnets" {
  description = "List of subnet self links"
  value       = [for _, s in google_compute_subnetwork.subnets : s.self_link]
}

output "private_subnets_map" {
  description = "Map of subnet name to subnet details"
  value = {
    for k, s in google_compute_subnetwork.subnets : k => {
      self_link     = s.self_link
      id            = s.id
      ip_cidr_range = s.ip_cidr_range
      region        = s.region
    }
  }
}

output "secondary_ranges_by_subnet" {
  description = "Per-subnet map of secondary range name to CIDR (for GKE: use range names as secondary_range_pod / secondary_range_services)"
  value = {
    for sn, ranges in var.secondary_ranges : sn => {
      for r in ranges : r.range_name => r.ip_cidr_range
    }
  }
}

output "region" {
  description = "Primary region (first subnet's region)"
  value       = length(var.subnets) > 0 ? var.subnets[0].subnet_region : null
}

output "gcp_cloud" {
  description = "GCP cloud details (project, network, subnetwork)"
  value = {
    project_id        = var.project_id
    network_name      = google_compute_network.vpc.name
    subnetwork_name   = length(var.subnets) > 0 ? var.subnets[0].subnet_name : null
    subnetwork_id     = length(google_compute_subnetwork.subnets) > 0 ? values(google_compute_subnetwork.subnets)[0].id : null
    shared_vpc_project = null
  }
}
