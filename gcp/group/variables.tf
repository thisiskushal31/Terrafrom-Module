variable "id" {
  type        = string
  description = "Group ID. For Google-managed groups, use the group email address (e.g. my-group@domain.com)"
}

variable "display_name" {
  type        = string
  default     = ""
  description = "Display name of the group"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the group"
}

variable "domain" {
  type        = string
  default     = ""
  description = "Organization domain (to resolve customer_id). One of domain or customer_id must be set"
}

variable "customer_id" {
  type        = string
  default     = ""
  description = "Customer ID of the organization. One of domain or customer_id must be set"
}

variable "initial_group_config" {
  type        = string
  default     = "EMPTY"
  description = "EMPTY, WITH_INITIAL_OWNER, or INITIAL_GROUP_CONFIG_UNSPECIFIED"
}

variable "types" {
  type        = list(string)
  default     = ["default"]
  description = "Group types: default, dynamic, security, external"
}

variable "owners" {
  type        = list(string)
  default     = []
  description = "Owner member IDs (e.g. user or service account emails)"
}

variable "managers" {
  type        = list(string)
  default     = []
  description = "Manager member IDs"
}

variable "members" {
  type        = list(string)
  default     = []
  description = "Member IDs"
}
