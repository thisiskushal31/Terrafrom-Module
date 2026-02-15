variable "name" {
  type        = string
  description = "Parameter name (path with leading / if needed)"
}

variable "type" {
  type        = string
  description = "String, StringList, or SecureString"
}

variable "value" {
  type        = string
  default     = ""
  description = "Value for String or StringList"
  sensitive   = true
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the parameter"
}

variable "key_id" {
  type        = string
  default     = null
  description = "KMS key ID/ARN for SecureString"
}

variable "overwrite" {
  type        = bool
  default     = false
  description = "Overwrite existing parameter"
}

variable "tier" {
  type        = string
  default     = "Standard"
  description = "Standard, Advanced, or Intelligent-Tiering"
}

variable "allowed_pattern" {
  type        = string
  default     = null
  description = "Regex to validate value"
}

variable "data_type" {
  type        = string
  default     = "text"
  description = "text, aws:ssm:integration, or aws:ec2:image"
}

variable "ignore_value_changes" {
  type        = bool
  default     = false
  description = "Ignore value changes after create (e.g. for secrets updated outside Terraform)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
