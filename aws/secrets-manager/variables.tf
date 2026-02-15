variable "name" {
  type        = string
  description = "Friendly name of the secret"
}

variable "description" {
  type        = string
  default     = null
  description = "Description of the secret"
}

variable "secret_string" {
  type        = string
  default     = null
  description = "Secret value (plaintext). Omit to set later or use binary."
  sensitive   = true
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "KMS key ARN/ID to encrypt the secret"
}

variable "recovery_window_in_days" {
  type        = number
  default     = 30
  description = "Days before secret can be deleted (0 to force delete, 7-30)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the secret"
}
