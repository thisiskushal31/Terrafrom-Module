variable "project_id" {
  type        = string
  description = "Project where service accounts are created"
}

variable "prefix" {
  type        = string
  default     = ""
  description = "Prefix for service account IDs"
}

variable "names" {
  type        = list(string)
  default     = []
  description = "Service account name suffixes"
}

variable "project_roles" {
  type        = list(string)
  default     = []
  description = "Roles to grant: project_id=>roles/role (empty project_id = this project)"
}

variable "description" {
  type        = string
  default     = ""
  description = "SA description"
}

variable "display_name" {
  type        = string
  default     = ""
  description = "SA display name"
}

variable "generate_keys" {
  type        = bool
  default     = false
  description = "Generate keys for service accounts"
}
