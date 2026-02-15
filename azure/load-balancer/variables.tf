variable "name" {
  type        = string
  description = "Load balancer name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name (from caller)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sku" {
  type        = string
  default     = "Standard"
  description = "Standard or Gateway"
}

variable "sku_tier" {
  type        = string
  default     = "Regional"
  description = "Regional or Global"
}

variable "public_ip_address_id" {
  type        = string
  default     = null
  description = "Public IP for public LB"
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "Subnet for private LB (internal)"
}

variable "private_ip_address" {
  type        = string
  default     = null
  description = "Static private IP when using subnet_id"
}

variable "probe_port" {
  type        = number
  default     = null
  description = "Health probe port (e.g. 80)"
}

variable "probe_protocol" {
  type        = string
  default     = "Tcp"
  description = "Tcp or Http"
}

variable "lb_rules" {
  type = map(object({
    protocol      = string
    frontend_port = number
    backend_port  = number
  }))
  default     = {}
  description = "Map of rule name to { protocol, frontend_port, backend_port }"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
