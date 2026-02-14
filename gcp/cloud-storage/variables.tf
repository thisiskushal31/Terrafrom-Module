variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "names" {
  type        = list(string)
  description = "Bucket name suffixes (prefix + name = full name)"
}

variable "prefix" {
  type        = string
  default     = ""
  description = "Prefix for bucket names"
}

variable "location" {
  type        = string
  default     = "US"
  description = "Location (US, EU, or region)"
}

variable "storage_class" {
  type        = string
  default     = "STANDARD"
  description = "Storage class"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels for all buckets"
}

variable "randomize_suffix" {
  type        = bool
  default     = false
  description = "Add random suffix to names"
}

variable "force_destroy" {
  type        = map(bool)
  default     = {}
  description = "Per-bucket force_destroy (key = lowercase name)"
}

variable "versioning" {
  type        = map(bool)
  default     = {}
  description = "Per-bucket versioning"
}

variable "uniform_bucket_level_access" {
  type        = map(bool)
  default     = {}
  description = "Per-bucket uniform bucket-level access"
}

variable "public_access_prevention" {
  type        = string
  default     = "inherited"
  description = "inherited or enforced"
}
