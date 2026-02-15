variable "name" {
  type        = string
  description = "Log group name (e.g. /aws/lambda/my-fn)"
}

variable "retention_in_days" {
  type        = number
  default     = null
  description = "Retention in days (null = never expire)"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "KMS key ARN for encryption"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
