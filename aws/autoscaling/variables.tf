variable "name" {
  type        = string
  description = "Name of the Auto Scaling group"
}

variable "min_size" {
  type        = number
  default     = 0
  description = "Minimum number of instances"
}

variable "max_size" {
  type        = number
  description = "Maximum number of instances"
}

variable "desired_capacity" {
  type        = number
  default     = null
  description = "Desired capacity (null = use min_size)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the ASG (from caller)"
}

variable "launch_template_id" {
  type        = string
  description = "Launch template ID (from caller)"
}

variable "launch_template_version" {
  type        = string
  default     = "$Latest"
  description = "Launch template version ($Latest, $Default, or version number)"
}

variable "health_check_type" {
  type        = string
  default     = "EC2"
  description = "EC2 or ELB"
}

variable "health_check_grace_period" {
  type        = number
  default     = 300
  description = "Grace period in seconds (for ELB health checks)"
}

variable "target_group_arns" {
  type        = list(string)
  default     = []
  description = "ALB/NLB target group ARNs for attachment"
}

variable "default_cooldown" {
  type        = number
  default     = null
  description = "Cooldown in seconds (null = default)"
}

variable "force_delete" {
  type        = bool
  default     = false
  description = "Force delete even if instances exist"
}

variable "termination_policies" {
  type        = list(string)
  default     = ["Default"]
  description = "Termination policy list"
}

variable "enabled_metrics" {
  type        = list(string)
  default     = []
  description = "List of metrics to enable (e.g. GroupDesiredCapacity)"
}

variable "protect_from_scale_in" {
  type        = bool
  default     = false
  description = "Protect instances from scale-in"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags (Name is merged automatically)"
}
