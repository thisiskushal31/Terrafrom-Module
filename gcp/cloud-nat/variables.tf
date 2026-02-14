variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "region" {
  type        = string
  description = "Region"
}

variable "router" {
  type        = string
  description = "Router name (existing or to create)"
}

variable "name" {
  type        = string
  default     = ""
  description = "NAT name (default: cloud-nat-<router>)"
}

variable "create_router" {
  type        = bool
  default     = false
  description = "Create a new Cloud Router"
}

variable "network" {
  type        = string
  default     = ""
  description = "VPC self link (required if create_router is true)"
}

variable "router_asn" {
  type        = number
  default     = null
  description = "Router ASN when creating router"
}

variable "router_keepalive_interval" {
  type        = number
  default     = 20
  description = "BGP keepalive when creating router"
}

variable "nat_ips" {
  type        = list(string)
  default     = []
  description = "Static IP self links for NAT"
}

variable "source_subnetwork_ip_ranges_to_nat" {
  type        = string
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  description = "Which subnetwork ranges to NAT"
}

variable "min_ports_per_vm" {
  type        = number
  default     = null
  description = "Min ports per VM"
}

variable "subnetworks" {
  type = list(object({
    name                     = string
    source_ip_ranges_to_nat  = list(string)
    secondary_ip_range_names = optional(list(string), [])
  }))
  default     = []
  description = "Per-subnetwork NAT config"
}

variable "log_config_enable" {
  type        = bool
  default     = false
  description = "Enable NAT logging"
}

variable "log_config_filter" {
  type        = string
  default     = "ALL"
  description = "Log filter: ERRORS_ONLY, TRANSLATIONS_ONLY, ALL"
}
