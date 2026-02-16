variable "name" {
  type        = string
  description = "Name of the Azure Cache for Redis (must be globally unique)"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name (from caller)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "capacity" {
  type        = number
  description = "Cache size: Basic/Standard C family 0–6; Premium P family 1–4"
}

variable "family" {
  type        = string
  description = "SKU family: C (Basic/Standard) or P (Premium)"
}

variable "sku_name" {
  type        = string
  description = "SKU: Basic, Standard, or Premium"
}

variable "enable_non_ssl_port" {
  type        = bool
  default     = false
  description = "Allow non-SSL port 6379"
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "Minimum TLS version: 1.0, 1.1, 1.2"
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "Subnet ID for Premium (VNet integration)"
}

variable "private_static_ip_address" {
  type        = string
  default     = null
  description = "Static private IP (Premium, must be in subnet)"
}

variable "redis_configuration" {
  type        = map(string)
  default     = {}
  description = "Redis config (e.g. maxmemory-policy)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
