/**
 * Log export: one sink at project, folder, org, or billing level.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID (for provider); parent_resource_id may be project/folder/org/billing"
}

variable "log_sink_name" {
  type        = string
  description = "Name of the log sink"
}

variable "destination_uri" {
  type        = string
  description = "Destination URI (e.g. storage.googleapis.com/BUCKET, pubsub.googleapis.com/projects/PROJECT/topics/TOPIC, bigquery.googleapis.com/projects/PROJECT/datasets/DATASET)"
}

variable "parent_resource_type" {
  type        = string
  default     = "project"
  description = "project, folder, organization, or billing_account"
}

variable "parent_resource_id" {
  type        = string
  description = "Project ID, folder ID, org ID, or billing account ID"
}

variable "filter" {
  type        = string
  default     = ""
  description = "Log filter (empty = all logs)"
}

variable "description" {
  type        = string
  default     = null
  description = "Sink description"
}

variable "unique_writer_identity" {
  type        = bool
  default     = true
  description = "Use a unique writer identity (recommended for granting destination access)"
}

variable "disabled" {
  type        = bool
  default     = false
  description = "Disable the sink"
}

variable "include_children" {
  type        = bool
  default     = false
  description = "For folder/org: include child projects"
}

variable "intercept_children" {
  type        = bool
  default     = false
  description = "For folder/org: intercept logs from child projects"
}

variable "bigquery_use_partitioned_tables" {
  type        = bool
  default     = null
  description = "For BigQuery destination: use partitioned tables (true/false)"
}

variable "exclusions" {
  type = list(object({
    name        = string
    description = optional(string)
    filter      = string
    disabled    = optional(bool, false)
  }))
  default     = []
  description = "Exclusion filters"
}
