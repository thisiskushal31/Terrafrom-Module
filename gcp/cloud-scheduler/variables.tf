variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "Job name"
}

variable "region" {
  type        = string
  description = "Region (e.g. us-central1)"
}

variable "schedule" {
  type        = string
  description = "Cron schedule (e.g. \"0 9 * * 1-5\")"
}

variable "description" {
  type        = string
  default     = ""
  description = "Job description"
}

variable "time_zone" {
  type        = string
  default     = "UTC"
  description = "Time zone (e.g. America/New_York)"
}

variable "attempt_deadline" {
  type        = string
  default     = "180s"
  description = "Deadline for job attempt"
}

variable "paused" {
  type        = bool
  default     = false
  description = "Whether the job is paused"
}

variable "retry_count" {
  type        = number
  default     = null
  description = "Number of retries (omit for default)"
}

variable "target_type" {
  type        = string
  description = "Target type: http or pubsub"
}

# HTTP target
variable "http_uri" {
  type        = string
  default     = ""
  description = "HTTP target URI (required when target_type = http)"
}

variable "http_method" {
  type        = string
  default     = "POST"
  description = "HTTP method"
}

variable "http_body" {
  type        = string
  default     = null
  description = "HTTP request body (optional)"
}

variable "http_headers" {
  type        = map(string)
  default     = null
  description = "HTTP headers"
}

variable "oidc_service_account_email" {
  type        = string
  default     = null
  description = "Service account for OIDC auth (HTTP target)"
}

# Pub/Sub target
variable "pubsub_topic_name" {
  type        = string
  default     = ""
  description = "Pub/Sub topic ID or full name (required when target_type = pubsub)"
}

variable "pubsub_data" {
  type        = string
  default     = null
  description = "Message data (optional, will be base64-encoded)"
}
