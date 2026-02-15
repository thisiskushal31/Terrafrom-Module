/**
 * Dataflow: Flex Template job or classic template job.
 */

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
  default     = "us-central1"
  description = "Region for the job"
}

variable "use_flex_template" {
  type        = bool
  default     = true
  description = "Use Flex Template (container_spec_gcs_path); if false, use classic template (template_gcs_path)"
}

variable "container_spec_gcs_path" {
  type        = string
  default     = ""
  description = "GCS path to Flex Template spec (required when use_flex_template = true)"
}

variable "template_gcs_path" {
  type        = string
  default     = ""
  description = "GCS path to classic template (required when use_flex_template = false)"
}

variable "temp_location" {
  type        = string
  default     = ""
  description = "GCS path for temp files (e.g. gs://bucket/temp). Required when use_flex_template = true."
}

variable "temp_gcs_location" {
  type        = string
  default     = ""
  description = "GCS bucket name for temp (classic job only; path will be gs://BUCKET/tmp_dir)"
}

variable "on_delete" {
  type        = string
  default     = "cancel"
  description = "On delete: drain or cancel"
}

variable "max_workers" {
  type        = number
  default     = 1
  description = "Max number of workers"
}

variable "parameters" {
  type        = map(string)
  default     = {}
  description = "Job parameters"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Job labels"
}

variable "service_account_email" {
  type        = string
  default     = ""
  description = "Service account for workers"
}

variable "network" {
  type        = string
  default     = ""
  description = "Network for workers"
}

variable "subnetwork" {
  type        = string
  default     = ""
  description = "Subnetwork for workers (e.g. regions/REGION/subnetworks/SUBNET)"
}

variable "machine_type" {
  type        = string
  default     = ""
  description = "Worker machine type"
}

variable "use_public_ips" {
  type        = bool
  default     = false
  description = "Use public IPs for workers"
}

variable "enable_streaming_engine" {
  type        = bool
  default     = false
  description = "Enable Streaming Engine"
}

variable "skip_wait_on_job_termination" {
  type        = bool
  default     = false
  description = "Skip waiting for job to terminate on destroy"
}

variable "kms_key_name" {
  type        = string
  default     = null
  description = "KMS key for the job"
}

variable "additional_experiments" {
  type        = list(string)
  default     = []
  description = "Additional experiments"
}
