/**
 * EKS module: cluster + optional managed node groups.
 * VPC/subnets from caller (e.g. aws/network). IAM roles for cluster and nodes are created by this module.
 */

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

# --- Access / RBAC (who can call the cluster API) ---
variable "authentication_mode" {
  type        = string
  default     = "API"
  description = "Authentication mode: CONFIG_MAP (legacy), API (IAM access entries), or API_AND_CONFIG_MAP"
}

variable "bootstrap_cluster_creator_admin_permissions" {
  type        = bool
  default     = false
  description = "Grant cluster creator admin permissions via bootstrap (one-time; prefer access entries for ongoing control)"
}

# --- IRSA (pods assume IAM roles via OIDC) — analogous to GKE Workload Identity ---
variable "enable_irsa" {
  type        = bool
  default     = true
  description = "Create OIDC identity provider for IRSA so pods can assume IAM roles via service account (like GKE Workload Identity)"
}

variable "cluster_version" {
  type        = string
  default     = null
  description = "Kubernetes version (e.g. 1.28); omit for latest"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for the cluster and node groups (from caller)"
}

variable "cluster_endpoint_public_access" {
  type        = bool
  default     = true
  description = "Enable public API endpoint"
}

variable "cluster_endpoint_private_access" {
  type        = bool
  default     = true
  description = "Enable private API endpoint"
}

variable "public_access_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDR blocks allowed to access the public API endpoint"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = ["api", "audit", "authenticator"]
  description = "CloudWatch log types to enable (api, audit, authenticator)"
}

variable "cloudwatch_log_retention_days" {
  type        = number
  default     = 90
  description = "Retention in days for cluster CloudWatch log groups"
}

variable "default_reclaim_policy" {
  type        = string
  default     = "Delete"
  description = "Default storage class reclaim policy: Delete or Retain"
}

variable "node_groups" {
  type = map(object({
    instance_types = list(string)
    min_size      = optional(number, 0)
    max_size      = optional(number, 10)
    desired_size  = optional(number, 1)
    disk_size     = optional(number, 100)
    capacity_type = optional(string, "ON_DEMAND")  # ON_DEMAND or SPOT
    labels        = optional(map(string), {})
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string
    })), [])
    ami_type       = optional(string, null)   # AL2_x86_64, AL2_ARM_64, CUSTOM
    ami_id         = optional(string, null)    # When ami_type = CUSTOM
  }))
  default     = {}
  description = "Map of node group name to config (managed node groups)"
}

variable "addons" {
  type = map(object({
    version     = optional(string, null)
    resolve_conflicts = optional(string, "OVERWRITE")
    preserve    = optional(bool, false)
    configuration_values = optional(string, null)
  }))
  default     = {}
  description = "EKS addons: addon_name -> { version, resolve_conflicts, preserve, configuration_values }"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to cluster and node groups"
}
