variable "cluster_identifier" {
  type        = string
  description = "Cluster identifier"
}

variable "node_type" {
  type        = string
  description = "Node type (e.g. dc2.large)"
}

variable "number_of_nodes" {
  type        = number
  default     = 1
  description = "Number of nodes (1 = single-node)"
}

variable "database_name" {
  type        = string
  default     = "dev"
  description = "Name of the default database"
}

variable "master_username" {
  type        = string
  description = "Master user name"
}

variable "master_password" {
  type        = string
  description = "Master password"
  sensitive   = true
}

variable "port" {
  type        = number
  default     = 5439
  description = "Port"
}

variable "subnet_ids" {
  type        = list(string)
  default     = []
  description = "Subnet IDs for subnet group (required when subnet_group_name is null)"
}

variable "subnet_group_name" {
  type        = string
  default     = null
  description = "Existing subnet group name (omit to create from subnet_ids)"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs (from caller)"
}

variable "publicly_accessible" {
  type        = bool
  default     = false
  description = "Publicly accessible"
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Skip final snapshot on delete"
}

variable "final_snapshot_identifier" {
  type        = string
  default     = null
  description = "Final snapshot name (when skip_final_snapshot = false)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
