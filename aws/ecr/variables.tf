variable "repository_name" {
  type        = string
  description = "Name of the ECR repository"
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "MUTABLE or IMMUTABLE"
}

variable "scan_on_push" {
  type        = bool
  default     = false
  description = "Enable image scan on push"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the repository"
}
