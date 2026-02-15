variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group (from caller)"
}

variable "location" {
  type        = string
  description = "Azure region (e.g. eastus)"
}

variable "address_space" {
  type        = list(string)
  description = "Address space(s) for the VNet (e.g. [\"10.0.0.0/16\"])"
}

variable "dns_servers" {
  type        = list(string)
  default     = []
  description = "Optional custom DNS servers"
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
  default     = {}
  description = "Map of subnet name to { address_prefix }"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
