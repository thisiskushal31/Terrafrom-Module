/**
 * Secret Manager: secrets + optional first version.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "secrets" {
  type = map(object({
    labels                 = optional(map(string), {})
    replication_locations  = optional(list(string))  # null = auto replication
    deletion_protection    = optional(bool, false)
    secret_data            = optional(string)         # if set, create one version (sensitive)
  }))
  default     = {}
  description = "Map of secret_id => config. secret_data optional; set via variable for initial version."
}
