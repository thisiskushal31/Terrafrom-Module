/**
 * S3 bucket module. Equivalent to gcp/cloud-storage (GCS buckets).
 * Reference: modules-clone/terraform-aws-s3-bucket
 */

variable "bucket" {
  type        = string
  description = "Bucket name (must be globally unique)"
}

variable "bucket_prefix" {
  type        = string
  default     = null
  description = "Prefix for bucket name (used with null bucket to generate name)"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Allow destroy even if bucket has objects"
}

variable "versioning" {
  type = object({
    enabled = optional(bool, false)
  })
  default     = {}
  description = "Versioning configuration"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the bucket"
}
