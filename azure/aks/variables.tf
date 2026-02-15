/**
 * AKS module: cluster + default node pool + optional additional node pools.
 * VNet/subnet from caller (e.g. azure/network). No cross-module resource creation.
 */

variable "resource_group_name" {
  type        = string
  description = "Azure resource group name"
}

variable "location" {
  type        = string
  description = "Azure region (e.g. eastus)"
}

variable "cluster_name" {
  type        = string
  description = "Name of the AKS cluster"
}

variable "kubernetes_version" {
  type        = string
  default     = null
  description = "Kubernetes version (e.g. 1.28). Omit for latest supported."
}

variable "vnet_subnet_id" {
  type        = string
  description = "Subnet ID for the cluster and node pools (from azure/network or similar)"
}

variable "default_node_pool" {
  type = object({
    vm_size       = string           # e.g. Standard_D4s_v5
    min_count     = optional(number, 1)
    max_count     = optional(number, 10)
    os_disk_size_gb = optional(number, 100)
    os_disk_type  = optional(string, "Managed")  # Managed or Ephemeral
    priority      = optional(string, "Regular")  # Regular or Spot
    node_labels   = optional(map(string), {})
    node_taints   = optional(list(string), [])
  })
  description = "Default node pool; at least one pool is required by AKS"
}

variable "maintenance_window" {
  type = object({
    day         = optional(string, "Monday")   # Day of week for maintenance
    start_hour  = optional(number, 2)          # 0-23
    duration_hours = optional(number, 6)       # 1-24
  })
  default     = null
  description = "Maintenance window for auto-upgrade; omit to use portal default"
}

variable "auto_upgrade_channel" {
  type        = string
  default     = null
  description = "Automatic upgrade channel: patch, rapid, stable, node_image, or null (none)"
}

variable "additional_node_pools" {
  type = map(object({
    vm_size         = string
    min_count       = optional(number, 0)
    max_count       = optional(number, 10)
    os_disk_size_gb = optional(number, 100)
    os_disk_type    = optional(string, "Managed")
    priority        = optional(string, "Regular")  # Regular or Spot
    node_labels     = optional(map(string), {})
    node_taints     = optional(list(string), [])
    max_pods        = optional(number, null)
  }))
  default     = {}
  description = "Additional node pools (name -> config)"
}

variable "enable_azure_policy" {
  type        = bool
  default     = false
  description = "Enable Azure Policy add-on"
}

variable "enable_http_application_routing" {
  type        = bool
  default     = false
  description = "Enable HTTP application routing (ingress)"
}

variable "network_plugin" {
  type        = string
  default     = "azure"
  description = "Network plugin: azure, kubenet, or none"
}

variable "network_policy" {
  type        = string
  default     = null
  description = "Network policy when network_plugin = azure: azure or calico"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to the cluster and node pools"
}
