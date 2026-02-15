variable "storage_account_name" {
  type        = string
  description = "Storage account name (3-24 chars, alphanumeric only)"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name (from caller)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Standard or Premium"
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "LRS, GRS, RAGRS, ZRS"
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "StorageV2, BlobStorage, etc."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "TLS version"
}

variable "containers" {
  type        = list(string)
  default     = []
  description = "Blob container names to create"
}

variable "container_access_type" {
  type        = string
  default     = "private"
  description = "private, blob, or container"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
