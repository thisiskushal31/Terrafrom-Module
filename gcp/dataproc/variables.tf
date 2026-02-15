variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "Cluster name"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "Region"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels"
}

variable "staging_bucket" {
  type        = string
  default     = null
  description = "GCS staging bucket (optional; Dataproc can create default)"
}

variable "master_num_instances" {
  type        = number
  default     = 1
  description = "Number of master instances"
}

variable "master_machine_type" {
  type        = string
  default     = "e2-standard-2"
  description = "Master machine type"
}

variable "master_boot_disk_type" {
  type        = string
  default     = "pd-standard"
  description = "Master boot disk type"
}

variable "master_boot_disk_size_gb" {
  type        = number
  default     = 35
  description = "Master boot disk size (GB)"
}

variable "worker_num_instances" {
  type        = number
  default     = 2
  description = "Number of worker instances"
}

variable "worker_machine_type" {
  type        = string
  default     = "e2-standard-2"
  description = "Worker machine type"
}

variable "worker_boot_disk_type" {
  type        = string
  default     = "pd-standard"
  description = "Worker boot disk type"
}

variable "worker_boot_disk_size_gb" {
  type        = number
  default     = 35
  description = "Worker boot disk size (GB)"
}

variable "override_properties" {
  type        = map(string)
  default     = {}
  description = "Software config overrides (e.g. dataproc:dataproc.allow.zero.workers = true)"
}
