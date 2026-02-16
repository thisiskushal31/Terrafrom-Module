variable "subscription_name" {
  type        = string
  description = "Name of the Redis Cloud (Redis Enterprise) subscription"
}

variable "database_name" {
  type        = string
  description = "Name of the database within the subscription"
}

variable "payment_method" {
  type        = string
  default     = "credit-card"
  description = "Payment method: credit-card or marketplace"
}

variable "payment_method_id" {
  type        = string
  default     = null
  description = "Payment method ID (required when payment_method is credit-card)"
}

variable "cloud_account_id" {
  type        = number
  default     = null
  description = "Redis Cloud account ID. Default = 1 (Redis Labs internal account). GCP subscriptions typically use Redis Labs internal account."
}

variable "region" {
  type        = string
  description = "GCP region (e.g. us-central1, europe-west1)"
}

variable "multiple_availability_zones" {
  type        = bool
  default     = true
  description = "Deploy across multiple availability zones"
}

variable "networking_deployment_cidr" {
  type        = string
  description = "Deployment CIDR for the subscription (must be /24, e.g. 10.0.0.0/24)"
}

variable "preferred_availability_zones" {
  type        = list(string)
  default     = []
  description = "Preferred availability zones (e.g. us-central1-a, us-central1-b, us-central1-f). Required when multiple_availability_zones is true."
}

variable "dataset_size_in_gb" {
  type        = number
  description = "Max dataset size in GB for the database (and creation_plan)"
}

variable "creation_plan_quantity" {
  type        = number
  default     = 1
  description = "Planned number of databases in the subscription (creation_plan)"
}

variable "replication" {
  type        = bool
  default     = true
  description = "Enable replication for the database"
}

variable "throughput_measurement_by" {
  type        = string
  default     = "operations-per-second"
  description = "Throughput measurement: operations-per-second or number-of-shards"
}

variable "throughput_measurement_value" {
  type        = number
  default     = 20000
  description = "Throughput value (e.g. ops/sec)"
}

variable "data_persistence" {
  type        = string
  default     = "none"
  description = "Data persistence: none, aof-every-1-second, aof-every-write, snapshot-every-1-hour, snapshot-every-6-hours, snapshot-every-12-hours"
}

variable "public_endpoint_access" {
  type        = bool
  default     = false
  description = "Allow public endpoint access for databases in this subscription"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the database (keys and values must be lowercase)"
}
