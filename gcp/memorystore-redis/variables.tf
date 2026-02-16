variable "name" {
  type        = string
  description = "Name of the Memorystore for Redis instance"
}

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "tier" {
  type        = string
  default     = "BASIC"
  description = "Tier: BASIC or STANDARD_HA (high availability with replica)"
}

variable "memory_size_gb" {
  type        = number
  description = "Memory size in GB (1–300 for BASIC; 1–100 per node for STANDARD_HA)"
}

variable "region" {
  type        = string
  description = "GCP region (e.g. us-central1)"
}

variable "location_id" {
  type        = string
  default     = null
  description = "Zone for BASIC tier (e.g. us-central1-a). Omit to use region for STANDARD_HA."
}

variable "alternative_location_id" {
  type        = string
  default     = null
  description = "Second zone for STANDARD_HA (e.g. us-central1-f). Required for STANDARD_HA."
}

variable "authorized_network" {
  type        = string
  default     = null
  description = "VPC network ID or self_link for private Redis. Requires private service connection if using shared VPC."
}

variable "redis_version" {
  type        = string
  default     = null
  description = "Redis version (e.g. REDIS_7_0). Null = default."
}

variable "display_name" {
  type        = string
  default     = null
  description = "Human-readable name for the instance"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels for the instance"
}

variable "reserved_ip_range" {
  type        = string
  default     = null
  description = "Reserved CIDR range for the instance (e.g. 10.0.0.0/29). Optional when using authorized_network."
}
