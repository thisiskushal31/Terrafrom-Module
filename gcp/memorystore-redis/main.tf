resource "google_redis_instance" "this" {
  name               = var.name
  project            = var.project_id
  tier               = var.tier
  memory_size_gb     = var.memory_size_gb
  region             = var.region
  location_id        = var.location_id
  alternative_location_id = var.alternative_location_id
  authorized_network = var.authorized_network
  redis_version      = var.redis_version
  display_name       = var.display_name
  labels             = var.labels
  reserved_ip_range  = var.reserved_ip_range
}
