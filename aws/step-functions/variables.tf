variable "name" {
  type        = string
  description = "Name of the state machine"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for the state machine (from caller)"
}

variable "definition" {
  type        = string
  description = "State machine definition (JSON string)"
}

variable "type" {
  type        = string
  default     = "STANDARD"
  description = "STANDARD or EXPRESS"
}

variable "publish" {
  type        = bool
  default     = false
  description = "Publish version on create/update"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
