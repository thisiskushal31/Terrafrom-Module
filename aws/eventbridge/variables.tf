variable "name" {
  type        = string
  description = "Rule name"
}

variable "schedule_expression" {
  type        = string
  default     = null
  description = "e.g. rate(5 minutes)"
}

variable "event_pattern" {
  type        = string
  default     = null
  description = "Event pattern JSON"
}

variable "target_arn" {
  type        = string
  default     = null
  description = "Target ARN"
}

variable "description" {
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
}
