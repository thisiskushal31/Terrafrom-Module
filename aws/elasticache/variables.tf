variable "replication_group_id" {
  type        = string
  description = "Identifier for the replication group"
}

variable "description" {
  type        = string
  default     = null
  description = "Description"
}

variable "engine" {
  type        = string
  default     = "redis"
  description = "redis or memcached (this module creates replication group = Redis only)"
}

variable "engine_version" {
  type        = string
  default     = null
  description = "Engine version (null = default)"
}

variable "node_type" {
  type        = string
  description = "Node type (e.g. cache.t3.micro)"
}

variable "num_cache_clusters" {
  type        = number
  default     = 1
  description = "Number of nodes (1 = single node, 2+ = cluster with replica)"
}

variable "port" {
  type        = number
  default     = 6379
  description = "Redis port"
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "Subnet IDs for the subnet group (required when subnet_group_name is null)"
}

variable "subnet_group_name" {
  type        = string
  default     = null
  description = "Existing subnet group name (omit to create one from subnet_ids)"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs (from caller)"
}

variable "at_rest_encryption_enabled" {
  type        = bool
  default     = false
  description = "Encrypt at rest (requires KMS)"
}

variable "transit_encryption_enabled" {
  type        = bool
  default     = false
  description = "Encrypt in transit (TLS)"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "KMS key for at-rest encryption"
}

variable "auth_token" {
  type        = string
  default     = null
  description = "Auth token (required if transit_encryption_enabled)"
  sensitive   = true
}

variable "automatic_failover_enabled" {
  type        = bool
  default     = false
  description = "Enable automatic failover"
}

variable "multi_az_enabled" {
  type        = bool
  default     = false
  description = "Multi-AZ"
}

variable "snapshot_retention_limit" {
  type        = number
  default     = 0
  description = "Days to retain snapshots (0 = disabled)"
}

variable "snapshot_window" {
  type        = string
  default     = null
  description = "Daily time window for snapshots (e.g. 03:00-05:00)"
}

variable "maintenance_window" {
  type        = string
  default     = null
  description = "Maintenance window (e.g. sun:05:00-sun:06:00)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
