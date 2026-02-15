variable "name" {
  type        = string
  description = "Queue name (use .fifo suffix for FIFO)"
}

variable "fifo_queue" {
  type        = bool
  default     = false
  description = "Create FIFO queue"
}

variable "delay_seconds" {
  type        = number
  default     = 0
  description = "Default delay in seconds"
}

variable "message_retention_seconds" {
  type        = number
  default     = 345600
  description = "Message retention (default 4 days)"
}

variable "visibility_timeout_seconds" {
  type        = number
  default     = 30
  description = "Visibility timeout"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
