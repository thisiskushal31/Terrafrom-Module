variable "projects" {
  type        = list(string)
  default     = []
  description = "Project IDs to apply IAM bindings to"
}

variable "bindings" {
  type        = map(list(string))
  default     = {}
  description = "Map of role => list of members (e.g. roles/viewer => [\"user:foo@example.com\"])"
}
