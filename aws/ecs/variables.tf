variable "cluster_name" {
  type        = string
  description = "Name of the ECS cluster"
}

variable "container_insights" {
  type        = bool
  default     = false
  description = "Enable Container Insights"
}

variable "task_definition_arn" {
  type        = string
  default     = null
  description = "Task definition ARN for the service (null = cluster only)"
}

variable "service_name" {
  type        = string
  default     = null
  description = "Service name (required when task_definition_arn is set)"
}

variable "desired_count" {
  type        = number
  default     = 1
  description = "Desired number of tasks"
}

variable "launch_type" {
  type        = string
  default     = "FARGATE"
  description = "FARGATE or EC2"
}

variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "Subnets for service (required for Fargate when task_definition_arn set)"
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "Security groups for service"
}

variable "assign_public_ip" {
  type        = bool
  default     = false
  description = "Assign public IP to tasks"
}

variable "target_group_arn" {
  type        = string
  default     = null
  description = "ALB/NLB target group ARN for service"
}

variable "load_balancer_container_name" {
  type        = string
  default     = null
  description = "Container name for load balancer (required if target_group_arn set)"
}

variable "load_balancer_container_port" {
  type        = number
  default     = 80
  description = "Container port for load balancer"
}

variable "deployment_minimum_healthy_percent" {
  type        = number
  default     = 100
  description = "Deployment minimum healthy percent"
}

variable "deployment_maximum_percent" {
  type        = number
  default     = 200
  description = "Deployment maximum percent"
}

variable "enable_execute_command" {
  type        = bool
  default     = false
  description = "Enable ECS Exec"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
