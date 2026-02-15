variable "name" {
  type        = string
  description = "Topic name (use .fifo suffix for FIFO)"
}

variable "fifo_topic" {
  type        = bool
  default     = false
  description = "Create FIFO topic"
}

variable "display_name" {
  type        = string
  default     = null
  description = "Display name for the topic"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
