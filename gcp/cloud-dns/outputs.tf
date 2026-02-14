output "zone_name" {
  description = "Managed zone name"
  value       = local.zone_resource.name
}

output "zone_id" {
  description = "Managed zone ID"
  value       = local.zone_resource.id
}

output "name_servers" {
  description = "Zone name servers"
  value       = local.zone_resource.name_servers
}

output "dns_name" {
  description = "Zone DNS name"
  value       = local.zone_resource.dns_name
}
