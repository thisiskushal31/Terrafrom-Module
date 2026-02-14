/**
 * Cloud DNS: one managed zone (public or private) + record sets.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "Zone name (unique in project)"
}

variable "domain" {
  type        = string
  description = "Zone DNS name (must end with a period, e.g. example.com.)"
}

variable "type" {
  type        = string
  default     = "private"
  description = "public or private"
}

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Zone description"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels for the zone"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Allow Terraform to delete all records in the zone"
}

variable "private_visibility_config_networks" {
  type        = list(string)
  default     = []
  description = "For private zones: list of VPC self links that can see this zone"
}

variable "recordsets" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
  default     = []
  description = "Record sets (name relative to zone; empty name = zone apex)"
}
