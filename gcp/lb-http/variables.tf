/**
 * Global HTTP(S) load balancer: one backend service, URL map, forwarding rule.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "name" {
  type        = string
  description = "Name for the LB and prefix for resources"
}

variable "create_address" {
  type        = bool
  default     = true
  description = "Create a new global IPv4 address"
}

variable "address" {
  type        = string
  default     = null
  description = "Existing global IPv4 address (when create_address is false)"
}

variable "backend_groups" {
  type        = list(string)
  default     = []
  description = "List of instance group or NEG self links for the backend"
}

variable "backend_port_name" {
  type        = string
  default     = "http"
  description = "Named port on backend instances"
}

variable "backend_timeout_sec" {
  type        = number
  default     = 30
  description = "Backend timeout in seconds"
}

variable "backend_max_utilization" {
  type        = number
  default     = 0.8
  description = "Max CPU utilization for backend balancing"
}

variable "enable_cdn" {
  type        = bool
  default     = false
  description = "Enable Cloud CDN on the backend service"
}

variable "health_check_port" {
  type        = number
  default     = 80
  description = "Health check port"
}

variable "health_check_path" {
  type        = string
  default     = "/"
  description = "Health check request path"
}

variable "health_check_interval_sec" {
  type        = number
  default     = 10
  description = "Health check interval in seconds"
}

variable "health_check_timeout_sec" {
  type        = number
  default     = 5
  description = "Health check timeout in seconds"
}

variable "health_check_healthy_threshold" {
  type        = number
  default     = 2
  description = "Healthy threshold"
}

variable "health_check_unhealthy_threshold" {
  type        = number
  default     = 3
  description = "Unhealthy threshold"
}

variable "http_port_range" {
  type        = string
  default     = "80"
  description = "Port range for HTTP forwarding rule"
}

variable "https_port_range" {
  type        = string
  default     = "443"
  description = "Port range for HTTPS forwarding rule"
}

variable "ssl_certificate_self_links" {
  type        = list(string)
  default     = null
  description = "List of SSL certificate self links for HTTPS; if null or empty, only HTTP forwarding rule is created"
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels for address and forwarding rules"
}
