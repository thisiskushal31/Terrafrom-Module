output "instance_id" {
  description = "Memorystore for Redis instance ID"
  value       = google_redis_instance.this.id
}

output "host" {
  description = "Redis instance host IP"
  value       = google_redis_instance.this.host
}

output "port" {
  description = "Redis instance port"
  value       = google_redis_instance.this.port
}

output "current_location_id" {
  description = "Current zone of the instance"
  value       = google_redis_instance.this.current_location_id
}
