variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "network_name" {
  type        = string
  description = "VPC name"
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "GLOBAL or REGIONAL"
}

variable "auto_create_subnetworks" {
  type        = bool
  default     = false
  description = "Auto-create subnets per region"
}

variable "description" {
  type        = string
  default     = ""
  description = "VPC description"
}

variable "mtu" {
  type        = number
  default     = 0
  description = "MTU (0 = default)"
}

variable "subnets" {
  type = list(object({
    subnet_name           = string
    subnet_ip             = string
    subnet_region         = string
    description           = optional(string)
    subnet_private_access = optional(bool, false)
  }))
  description = "Subnets to create"
}

variable "secondary_ranges" {
  type        = map(list(object({ range_name = string, ip_cidr_range = string })))
  default     = {}
  description = "Secondary ranges per subnet name"
}

variable "routes" {
  type = list(object({
    name                   = string
    dest_range             = string
    next_hop_gateway       = optional(string)
    next_hop_ip            = optional(string)
    next_hop_instance      = optional(string)
    next_hop_vpc_peering   = optional(string)
    priority               = optional(number)
  }))
  default     = []
  description = "Routes to create"
}

variable "ingress_rules" {
  type = list(object({
    name          = string
    description   = optional(string)
    priority      = optional(number)
    source_ranges = optional(list(string), [])
    source_tags   = optional(list(string))
    target_tags   = optional(list(string))
    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
  }))
  default = []
  description = "Ingress firewall rules"
}

variable "egress_rules" {
  type = list(object({
    name               = string
    description        = optional(string)
    priority           = optional(number)
    destination_ranges = optional(list(string), [])
    target_tags        = optional(list(string))
    allow = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
    deny = optional(list(object({
      protocol = string
      ports    = optional(list(string))
    })), [])
  }))
  default = []
  description = "Egress firewall rules"
}

# Private Service Access (VPC peering for Cloud SQL private IP, etc.)
variable "enable_private_service_access" {
  type        = bool
  default     = false
  description = "Enable Private Service Access: reserve a range and peer with servicenetworking.googleapis.com"
}

variable "private_service_access_address" {
  type        = string
  default     = ""
  description = "First IP of the range for Private Service Access (empty = GCP chooses)"
}

variable "private_service_access_prefix_length" {
  type        = number
  default     = 16
  description = "Prefix length for Private Service Access range (/16 typical)"
}

variable "private_service_access_description" {
  type        = string
  default     = ""
  description = "Description for the reserved range"
}

variable "private_service_access_labels" {
  type        = map(string)
  default     = {}
  description = "Labels for the reserved range"
}
