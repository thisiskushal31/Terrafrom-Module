variable "name" {
  type        = string
  description = "Role name"
}

variable "service_principal" {
  type        = string
  description = "Service to allow assume (e.g. lambda.amazonaws.com, ec2.amazonaws.com)"
}

variable "policy_arns" {
  type        = list(string)
  default     = []
  description = "Managed policy ARNs to attach"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
