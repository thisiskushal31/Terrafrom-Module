/**
 * Cloud Function: source from local directory, event trigger (e.g. Pub/Sub) or HTTP trigger.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "Function name"
}

variable "region" {
  type        = string
  description = "Region for the function"
}

variable "source_directory" {
  type        = string
  description = "Path to the function source directory (will be zipped)"
}

variable "files_to_exclude" {
  type        = list(string)
  default     = []
  description = "Files to exclude from the zip"
}

variable "runtime" {
  type        = string
  description = "Runtime (e.g. nodejs20, python311)"
}

variable "entry_point" {
  type        = string
  description = "Entry point function name"
}

variable "event_trigger" {
  type = object({
    event_type = string
    resource   = string
  })
  default     = null
  description = "Event trigger (e.g. event_type = \"google.pubsub.topic.publish\", resource = topic name). Omit and set trigger_http = true for HTTP."
}

variable "trigger_http" {
  type        = bool
  default     = false
  description = "Use HTTP trigger instead of event trigger"
}

variable "event_trigger_failure_retry" {
  type        = bool
  default     = false
  description = "Retry on failure for event trigger"
}

variable "available_memory_mb" {
  type        = number
  default     = 256
  description = "Memory in MB"
}

variable "timeout_s" {
  type        = number
  default     = 60
  description = "Timeout in seconds"
}

variable "description" {
  type        = string
  default     = null
  description = "Function description"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables"
}

variable "bucket_name" {
  type        = string
  description = "GCS bucket name for function source (from cloud-storage module)"
}
