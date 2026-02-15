variable "description" {
  type        = string
  default     = null
  description = "Description of the KMS key"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 30
  description = "Days before key can be deleted (7-30)"
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Enable automatic key rotation"
}

variable "alias" {
  type        = string
  default     = null
  description = "Display name alias (e.g. my-key)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the key"
}
