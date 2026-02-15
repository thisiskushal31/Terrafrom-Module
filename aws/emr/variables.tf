variable "name" {
  type        = string
  description = "Cluster name"
}

variable "release_label" {
  type        = string
  description = "EMR release (e.g. emr-6.15.0)"
}

variable "service_role_arn" {
  type        = string
  description = "IAM role for EMR service (from caller)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet for the cluster"
}

variable "instance_type" {
  type        = string
  default     = "m5.xlarge"
  description = "Instance type for master and core"
}

variable "instance_count_core" {
  type        = number
  default     = 1
  description = "Number of core nodes"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
