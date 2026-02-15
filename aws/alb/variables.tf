variable "name" {
  type        = string
  description = "Load balancer name"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs (e.g. from vpc module)"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs for the ALB"
}

variable "internal" {
  type        = bool
  default     = false
  description = "Internal (private) ALB"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
