/**
 * Cloud Datastore: composite indexes.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "indexes" {
  type = list(object({
    id        = optional(string)
    kind      = string
    ancestor  = optional(string, "NONE")
    properties = list(object({
      name      = string
      direction = string
    }))
  }))
  default     = []
  description = "List of composite indexes (id optional, used as Terraform key)"
}
