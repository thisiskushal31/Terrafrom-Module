variable "name" {
  type        = string
  description = "Name of the notebook instance"
}

variable "instance_type" {
  type        = string
  default     = "ml.t3.medium"
  description = "ML instance type (e.g. ml.t3.medium, ml.p2.xlarge)"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for the notebook (from caller; needs sagemaker and EC2/VPC permissions)"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the instance (from caller)"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs (from caller)"
}

variable "direct_internet_access" {
  type        = bool
  default     = true
  description = "Allow direct internet access (set false when using VPC-only)"
}

variable "volume_size_in_gb" {
  type        = number
  default     = 5
  description = "EBS volume size in GB"
}

variable "kms_key_id" {
  type        = string
  default     = null
  description = "KMS key for volume encryption"
}

variable "lifecycle_config_name" {
  type        = string
  default     = null
  description = "Lifecycle config for on-create or on-start scripts"
}

variable "default_code_repository" {
  type        = string
  default     = null
  description = "Default Git repo to clone (CodeCommit, GitHub, etc.)"
}

variable "root_access" {
  type        = bool
  default     = true
  description = "Whether root access is enabled"
}

variable "platform_identifier" {
  type        = string
  default     = null
  description = "Platform identifier (e.g. notebook-al2-v2)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
