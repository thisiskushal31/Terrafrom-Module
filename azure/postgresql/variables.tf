variable "server_name" {
  type        = string
  description = "PostgreSQL server name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name (from caller)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "postgres_version" {
  type        = string
  default     = "16"
  description = "PostgreSQL version (14, 15, 16)"
}

variable "administrator_login" {
  type        = string
  description = "Admin login name"
}

variable "administrator_password" {
  type        = string
  description = "Admin password"
  sensitive   = true
}

variable "sku_name" {
  type        = string
  default     = "GP_Standard_D2s_v3"
  description = "SKU name"
}

variable "storage_mb" {
  type        = number
  default     = 32768
  description = "Storage in MB"
}

variable "zone" {
  type        = string
  default     = null
  description = "Availability zone or null"
}

variable "delegated_subnet_id" {
  type        = string
  default     = null
  description = "Subnet for private access"
}

variable "private_dns_zone_id" {
  type        = string
  default     = null
  description = "Private DNS zone ID"
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "Allow public access"
}

variable "databases" {
  type        = list(string)
  default     = []
  description = "Database names to create"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
