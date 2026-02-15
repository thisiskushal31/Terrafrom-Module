variable "identifier" {
  type        = string
  description = "DB instance identifier"
}

variable "engine" {
  type        = string
  description = "Engine e.g. mysql or postgres"
}

variable "engine_version" {
  type        = string
  default     = null
  description = "Engine version"
}

variable "instance_class" {
  type        = string
  description = "Instance class e.g. db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "Storage in GB"
}

variable "db_name" {
  type        = string
  default     = null
  description = "Database name"
}

variable "username" {
  type        = string
  description = "Master username"
}

variable "password" {
  type        = string
  description = "Master password"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for DB subnet group"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs"
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
  description = "Skip final snapshot on destroy"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
