variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "location" {
  type        = string
  description = "Location (region) for the repository (e.g. us-central1)"
}

variable "repository_id" {
  type        = string
  description = "Repository ID (short name)"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the repository"
}

variable "format" {
  type        = string
  default     = "DOCKER"
  description = "Format: DOCKER, MAVEN, NPM, PYTHON, APT, YUM, etc."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels"
}
