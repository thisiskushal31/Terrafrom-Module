variable "function_name" {
  type        = string
  description = "Lambda function name"
}

variable "handler" {
  type        = string
  description = "Handler (e.g. index.handler)"
}

variable "runtime" {
  type        = string
  description = "Runtime (e.g. python3.12, nodejs20.x)"
}

variable "role_arn" {
  type        = string
  description = "IAM role ARN for the function (from caller)"
}

variable "filename" {
  type        = string
  default     = null
  description = "Path to zip file (local)"
}

variable "s3_bucket" {
  type        = string
  default     = null
  description = "S3 bucket for deployment package (use with s3_key)"
}

variable "s3_key" {
  type        = string
  default     = null
  description = "S3 object key for deployment package"
}

variable "memory_size" {
  type        = number
  default     = 128
  description = "Memory size in MB"
}

variable "timeout" {
  type        = number
  default     = 3
  description = "Timeout in seconds"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
