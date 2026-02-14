output "instance" {
  description = "The Compute Engine instance resource"
  value       = google_compute_instance.vm
}

output "instance_id" {
  description = "Instance ID"
  value       = google_compute_instance.vm.instance_id
}

output "name" {
  description = "Instance name"
  value       = google_compute_instance.vm.name
}

output "self_link" {
  description = "Instance self link"
  value       = google_compute_instance.vm.self_link
}

output "network_interface" {
  description = "Primary network interface details"
  value       = google_compute_instance.vm.network_interface
}

output "internal_ip" {
  description = "Primary internal IP"
  value       = try(google_compute_instance.vm.network_interface[0].network_ip, null)
}

output "external_ip" {
  description = "Primary external IP (if assign_public_ip was true)"
  value       = try(google_compute_instance.vm.network_interface[0].access_config[0].nat_ip, null)
}

output "additional_disk_self_link" {
  description = "Self link of the additional disk (if created)"
  value       = var.enable_additional_disk ? google_compute_disk.additional[0].self_link : null
}
