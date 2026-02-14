variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "dataset_id" {
  type        = string
  description = "Dataset ID"
}

variable "dataset_name" {
  type        = string
  default     = null
  description = "Friendly name (defaults to dataset_id)"
}

variable "description" {
  type        = string
  default     = null
  description = "Dataset description"
}

variable "location" {
  type        = string
  default     = "US"
  description = "Location (US, EU, or region)"
}

variable "default_table_expiration_ms" {
  type        = number
  default     = null
  description = "Default table TTL in ms"
}

variable "delete_contents_on_destroy" {
  type        = bool
  default     = null
  description = "Delete tables when dataset is destroyed"
}

variable "dataset_labels" {
  type        = map(string)
  default     = {}
  description = "Dataset labels"
}

variable "tables" {
  type = list(object({
    table_id   = string
    schema     = optional(list(object({
      name = string
      type = string
      mode = optional(string)
      description = optional(string)
    })))
    description = optional(string)
    expiration_time = optional(number)
    labels = optional(map(string))
    time_partitioning = optional(object({
      type                     = string
      field                    = optional(string)
      require_partition_filter = optional(bool)
      expiration_ms            = optional(number)
    }))
    clustering = optional(list(string))
  }))
  default     = []
  description = "Table definitions"
}

variable "views" {
  type = list(object({
    view_id   = string
    query     = string
    description = optional(string)
    use_legacy_sql = optional(bool, false)
    labels = optional(map(string))
  }))
  default     = []
  description = "View definitions"
}
