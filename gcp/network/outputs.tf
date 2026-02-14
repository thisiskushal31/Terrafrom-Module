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
