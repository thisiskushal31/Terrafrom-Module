variable "name" {
  type        = string
  description = "Name of the NSG"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name (from caller)"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "inbound_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string, "*")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
  }))
  default     = []
  description = "List of inbound security rules"
}

variable "outbound_rules" {
  type = list(object({
    name                       = string
    priority                   = number
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string, "*")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
  }))
  default     = []
  description = "List of outbound security rules"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
