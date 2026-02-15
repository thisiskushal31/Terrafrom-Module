variable "parent_type" {
  type        = string
  description = "Parent type: project, folder, or organization"
}

variable "parent_id" {
  type        = string
  description = "Project ID, folder ID, or organization ID"
}

variable "constraint" {
  type        = string
  description = "Constraint name (e.g. constraints/compute.disableSerialPortAccess)"
}

variable "policy_type" {
  type        = string
  default     = "boolean"
  description = "boolean or list"
}

# Boolean policy
variable "enforce" {
  type        = bool
  default     = true
  description = "For boolean: true = enforce, false = allow (policy_type = boolean)"
}

# List policy
variable "list_allow_all" {
  type        = bool
  default     = null
  description = "For list: allow all values (policy_type = list)"
}

variable "list_deny_all" {
  type        = bool
  default     = null
  description = "For list: deny all values (policy_type = list)"
}

variable "allow_values" {
  type        = list(string)
  default     = null
  description = "For list: allowed values (use with policy_type = list)"
}

variable "deny_values" {
  type        = list(string)
  default     = null
  description = "For list: denied values (use with policy_type = list)"
}
