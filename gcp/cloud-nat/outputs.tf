output "router_name" {
  description = "Cloud Router name"
  value       = local.router_name
}

output "nat_name" {
  description = "Cloud NAT name"
  value       = google_compute_router_nat.nat.name
}
