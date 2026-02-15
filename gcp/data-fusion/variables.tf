/**
 * Data Fusion: one instance (BASIC or ENTERPRISE, public or private).
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "Instance name"
}

variable "region" {
  type        = string
  description = "Region for the instance"
}

variable "type" {
  type        = string
  default     = "ENTERPRISE"
  description = "BASIC or ENTERPRISE"
}

variable "description" {
  type        = string
  default     = null
  description = "Optional description"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Resource labels"
}

variable "datafusion_version" {
  type        = string
  default     = null
  description = "Data Fusion version (null = default)"
}

variable "options" {
  type        = map(string)
  default     = {}
  description = "Additional options"
}

variable "enable_stackdriver_logging" {
  type        = bool
  default     = true
  description = "Enable Stackdriver logging"
}

variable "enable_stackdriver_monitoring" {
  type        = bool
  default     = true
  description = "Enable Stackdriver monitoring"
}

variable "network_config" {
  type = object({
    network       = string
    ip_allocation = string
  })
  default     = null
  description = "For private instance: network name and IP allocation CIDR (e.g. from a reserved address)"
}
