variable "environment_display_name" {
  type        = string
  description = "Display name for the Confluent Cloud environment"
}

variable "stream_governance_package" {
  type        = string
  default     = null
  description = "Stream governance package: ESSENTIALS or ADVANCED. Omit to disable."
}

variable "cluster_display_name" {
  type        = string
  description = "Display name for the Kafka cluster"
}

variable "cluster_cloud" {
  type        = string
  default     = "AWS"
  description = "Cloud provider for the Kafka cluster: AWS, AZURE, or GCP"
}

variable "cluster_region" {
  type        = string
  description = "Region for the Kafka cluster (e.g. us-east-1, centralus, us-central1). See Confluent docs for supported regions per cloud."
}

variable "cluster_availability" {
  type        = string
  default     = "SINGLE_ZONE"
  description = "Availability: SINGLE_ZONE, MULTI_ZONE, LOW, or HIGH"
}

variable "cluster_type" {
  type        = string
  default     = "basic"
  description = "Cluster type: basic, standard, dedicated, enterprise, or freight (freight is AWS only)"
}

variable "cluster_dedicated_cku" {
  type        = number
  default     = 2
  description = "Number of CKUs for dedicated cluster type (min 1 SINGLE_ZONE, 2+ MULTI_ZONE)"
}

variable "cluster_standard_max_ecku" {
  type        = number
  default     = null
  description = "Max eCKUs for standard/enterprise/freight cluster (optional)"
}

variable "cluster_network_id" {
  type        = string
  default     = null
  description = "Confluent Network ID for private networking (optional)"
}

variable "cluster_byok_key_id" {
  type        = string
  default     = null
  description = "BYOK key ID (e.g. cck-xxx) for cluster encryption at rest. Create via confluent_byok_key first."
}

variable "create_service_account" {
  type        = bool
  default     = false
  description = "Create a service account for cluster access"
}

variable "service_account_display_name" {
  type        = string
  default     = "terraform-managed-sa"
  description = "Display name for the created service account"
}

variable "service_account_description" {
  type        = string
  default     = null
  description = "Description for the service account (defaults to Terraform-managed description if null)"
}

# RBAC: grant the service account a role on the Kafka cluster (e.g. Operator, CloudClusterAdmin, DeveloperRead)
variable "service_account_cluster_role_name" {
  type        = string
  default     = null
  description = "RBAC role to grant the service account on the Kafka cluster (e.g. Operator, CloudClusterAdmin, DeveloperRead). Uses cluster rbac_crn as crn_pattern."
}

# RBAC: additional role bindings (e.g. Schema Registry, environment) — list of { role_name, crn_pattern }
variable "service_account_role_bindings" {
  type = list(object({
    role_name   = string
    crn_pattern = string
  }))
  default     = []
  description = "Additional RBAC role bindings for the service account. Each needs role_name and crn_pattern (CRN of the resource)."
}

variable "create_topics" {
  type        = list(string)
  default     = []
  description = "List of Kafka topic names to create"
}

variable "topic_partitions_count" {
  type        = number
  default     = 6
  description = "Default number of partitions for created topics"
}

variable "topic_config" {
  type        = map(string)
  default     = {}
  description = "Optional topic config for all created topics (e.g. retention.ms, cleanup.policy, min.insync.replicas). See Confluent topic configuration reference."
}

variable "prevent_destroy" {
  type        = bool
  default     = false
  description = "Set lifecycle prevent_destroy on environment and cluster"
}
