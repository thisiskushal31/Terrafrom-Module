/**
 * GKE module: cluster + one or more node pools. Use gcp/network for VPC; manage IAM via gcp/iam.
 */

variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "GCP region for the cluster"
}

variable "cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
}

variable "description" {
  type        = string
  default     = ""
  description = "Description of the cluster"
}

variable "deletion_protection" {
  type        = bool
  default     = false
  description = "Enable deletion protection on the cluster"
}

variable "enable_vertical_pod_autoscaling" {
  type        = bool
  default     = false
  description = "Enable Vertical Pod Autoscaling"
}

variable "default_max_pods_per_node" {
  type        = number
  default     = null
  description = "Default max pods per node for the cluster (null = use GKE default)"
}

variable "enable_shielded_nodes" {
  type        = bool
  default     = true
  description = "Enable Shielded GKE nodes"
}

variable "network_self_link" {
  type        = string
  description = "VPC self link (e.g. from gcp/network output network_self_link)"
}

variable "subnetwork_self_link" {
  type        = string
  description = "Subnet self link (e.g. from gcp/network subnet_self_links)"
}

variable "secondary_range_pod" {
  type        = string
  description = "Name of the secondary range for pods (subnet secondary_ip_range)"
}

variable "secondary_range_services" {
  type        = string
  description = "Name of the secondary range for services"
}

variable "enable_private_nodes" {
  type        = bool
  default     = true
  description = "Use private GKE nodes (no public IPs)"
}

variable "enable_workload_logging" {
  type        = bool
  default     = false
  description = "Enable workload (container) logging"
}

variable "enable_node_auto_provisioning" {
  type        = bool
  default     = false
  description = "Enable GKE node auto-provisioning (cluster_autoscaling)"
}

variable "node_auto_provisioning_cpu_min" {
  type        = number
  default     = 0
  description = "Min CPU cores for node auto-provisioning resource limit"
}

variable "node_auto_provisioning_cpu_max" {
  type        = number
  default     = 100
  description = "Max CPU cores for node auto-provisioning resource limit"
}

variable "node_auto_provisioning_memory_min" {
  type        = number
  default     = 0
  description = "Min memory GB for node auto-provisioning resource limit"
}

variable "node_auto_provisioning_memory_max" {
  type        = number
  default     = 100
  description = "Max memory GB for node auto-provisioning resource limit"
}

variable "master_authorized_networks" {
  type        = list(string)
  default     = []
  description = "CIDR blocks allowed to reach the master (empty = all)"
}

variable "gcp_public_cidrs_access_enabled" {
  type        = bool
  default     = null
  description = "Allow master access from Google Cloud public IP ranges (null = not set)"
}

variable "enable_private_endpoint" {
  type        = bool
  default     = false
  description = "Use private endpoint for the cluster API (master internal IP only)"
}

variable "master_global_access_enabled" {
  type        = bool
  default     = true
  description = "Whether master is accessible globally when using private endpoint"
}

variable "master_ipv4_cidr_block" {
  type        = string
  default     = null
  description = "CIDR for hosted master network (null = use default 172.16.0.0/28)"
}

# --- Addons (addons_config) ---
variable "http_load_balancing" {
  type        = bool
  default     = true
  description = "Enable HTTP load balancing addon"
}

variable "horizontal_pod_autoscaling" {
  type        = bool
  default     = true
  description = "Enable horizontal pod autoscaling addon"
}

variable "network_policy" {
  type        = bool
  default     = false
  description = "Enable network policy addon"
}

variable "network_policy_provider" {
  type        = string
  default     = "CALICO"
  description = "Network policy provider: CALICO or CILIUM"
}

variable "dns_cache" {
  type        = bool
  default     = false
  description = "Enable NodeLocal DNSCache addon"
}

variable "filestore_csi_driver" {
  type        = bool
  default     = false
  description = "Enable Filestore CSI driver addon"
}

variable "gce_pd_csi_driver" {
  type        = bool
  default     = true
  description = "Enable GCE PD CSI driver addon"
}

variable "gcs_fuse_csi_driver" {
  type        = bool
  default     = false
  description = "Enable GCS Fuse CSI driver addon"
}

variable "config_connector" {
  type        = bool
  default     = false
  description = "Enable Config Connector addon"
}

variable "enable_secret_manager_addon" {
  type        = bool
  default     = false
  description = "Enable Secret Manager addon"
}

# --- Auth & security ---
variable "issue_client_certificate" {
  type        = bool
  default     = false
  description = "Issue client cert for cluster API (not recommended for production)"
}

variable "enable_binary_authorization" {
  type        = bool
  default     = false
  description = "Enable Binary Authorization admission controller"
}

variable "database_encryption" {
  type = list(object({
    state    = string # ENCRYPTED or DECRYPTED
    key_name = string # Cloud KMS key name for ENCRYPTED
  }))
  default     = [{ state = "DECRYPTED", key_name = "" }]
  description = "Application-layer Secrets Encryption; key_name required when state = ENCRYPTED"
}

variable "security_posture_mode" {
  type        = string
  default     = "DISABLED"
  description = "Security posture: DISABLED or BASIC"
}

variable "security_posture_vulnerability_mode" {
  type        = string
  default     = "VULNERABILITY_DISABLED"
  description = "Vulnerability mode: VULNERABILITY_DISABLED, VULNERABILITY_BASIC, or VULNERABILITY_ENTERPRISE"
}

variable "workload_identity_config" {
  type        = string
  default     = null
  description = "Workload pool for Workload Identity (e.g. project_id.svc.id.goog). null = disabled"
}

variable "enable_identity_service" {
  type        = bool
  default     = null
  description = "Enable Identity Service (e.g. for Anthos). null = not set"
}

# --- DNS ---
variable "cluster_dns" {
  type        = string
  default     = "PROVIDER_UNSPECIFIED"
  description = "In-cluster DNS: PROVIDER_UNSPECIFIED, PLATFORM_DEFAULT, or CLOUD_DNS"
}

variable "cluster_dns_scope" {
  type        = string
  default     = "DNS_SCOPE_UNSPECIFIED"
  description = "DNS scope: DNS_SCOPE_UNSPECIFIED, CLUSTER_SCOPE, or VPC_SCOPE"
}

variable "cluster_dns_domain" {
  type        = string
  default     = ""
  description = "Cluster DNS domain (required for some DNS scopes)"
}

# --- Monitoring (optional; when set use monitoring_config instead of default) ---
variable "monitoring_enabled_components" {
  type        = list(string)
  default     = []
  description = "Monitoring components (e.g. SYSTEM_COMPONENTS). Empty = use default monitoring"
}

variable "enable_managed_prometheus" {
  type        = bool
  default     = false
  description = "Enable Managed Prometheus in monitoring_config"
}

# --- Maintenance exclusions & notifications ---
variable "maintenance_exclusions" {
  type = list(object({
    name             = string
    start_time       = string # RFC3339
    end_time         = string
    exclusion_scope  = optional(string) # e.g. NO_UPGRADES
  }))
  default     = []
  description = "Maintenance exclusions (e.g. to pause upgrades)"
}

variable "notification_config_topic" {
  type        = string
  default     = ""
  description = "Pub/Sub topic for cluster notifications (e.g. upgrade events). Format: projects/PROJECT/topics/TOPIC"
}

variable "notification_config_event_types" {
  type        = list(string)
  default     = []
  description = "Event types to send: UPGRADE_AVAILABLE_EVENT, UPGRADE_EVENT, SECURITY_BULLETIN_EVENT"
}

# --- Network & datapath ---
variable "disable_default_snat" {
  type        = bool
  default     = false
  description = "Disable default SNAT (for private use of public IPs)"
}

variable "datapath_provider" {
  type        = string
  default     = "DATAPATH_PROVIDER_UNSPECIFIED"
  description = "Datapath: DATAPATH_PROVIDER_UNSPECIFIED or ADVANCED_DATAPATH (Dataplane V2)"
}

variable "stack_type" {
  type        = string
  default     = "IPV4"
  description = "Stack type: IPV4 or IPV4_IPV6"
}

variable "enable_intranode_visibility" {
  type        = bool
  default     = false
  description = "Enable intranode visibility (pod-to-pod traffic visibility)"
}

variable "service_external_ips" {
  type        = bool
  default     = false
  description = "Allow Services to use external IPs"
}

variable "enable_fqdn_network_policy" {
  type        = bool
  default     = null
  description = "Enable FQDN network policy. null = not set"
}

variable "gateway_api_channel" {
  type        = string
  default     = null
  description = "Gateway API channel: CHANNEL_STANDARD or CHANNEL_DISABLED. null = not set"
}

variable "maintenance_start_hour" {
  type        = number
  default     = 3
  description = "Start hour for maintenance window (0-23)"
}

variable "maintenance_days" {
  type        = list(string)
  default     = ["SUNDAY"]
  description = "Days for maintenance (e.g. SUNDAY, MONDAY)"
}

variable "maintenance_duration_hours" {
  type        = number
  default     = 4
  description = "Maintenance window duration in hours (1-24)"
}

variable "release_channel" {
  type        = string
  default     = "REGULAR"
  description = "Release channel: UNSPECIFIED, RAPID, REGULAR, STABLE"
}

variable "kubernetes_version" {
  type        = string
  default     = null
  description = "Static Kubernetes version (optional; use release_channel when null)"
}

# Node pools: map of pool name to config. Can define one or multiple pools.
variable "node_pools" {
  type = map(object({
    machine_type       = string
    disk_size_gb       = optional(number, 100)
    disk_type          = optional(string, "pd-standard")   # pd-standard, pd-balanced, pd-ssd
    node_lifecycle     = optional(string, "SPOT")         # ON_DEMAND or SPOT
    min_nodes          = optional(number, 0)
    max_nodes          = optional(number, 3)
    max_pods_per_node  = optional(number, null)          # null = use cluster default
    zones              = optional(list(string), [])
    enable_secure_boot = optional(bool, false)
    service_account    = optional(string, null)
    image_type        = optional(string, "COS_CONTAINERD")
    min_cpu_platform  = optional(string, null)
    taints = optional(list(object({
      key    = string
      value  = string
      effect = string   # NO_SCHEDULE, PREFER_NO_SCHEDULE, NO_EXECUTE
    })), [])
    labels     = optional(map(string), {})
    tags       = optional(list(string), [])              # network tags for firewall targeting
    auto_repair  = optional(bool, true)
    auto_upgrade = optional(bool, true)                  # overrides module-level auto_upgrade when set per pool
    max_surge       = optional(number, 1)                # for upgrade_settings SURGE
    max_unavailable = optional(number, 0)
    guest_accelerator = optional(object({
      type  = string   # e.g. nvidia-tesla-t4
      count = number
    }), null)
  }))
  default     = {}
  description = "Map of node pool name to config. Empty = no node pools."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels applied to the cluster"
}
