variable "cluster_name" {
  type        = string
  description = "Name of the MSK cluster"
}

variable "kafka_version" {
  type        = string
  description = "Kafka version (e.g. 3.5.1)"
}

variable "number_of_broker_nodes" {
  type        = number
  description = "Number of broker nodes (e.g. 3 for AZ spread)"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for brokers (from caller)"
}

variable "security_group_ids" {
  type        = list(string)
  description = "Security group IDs for brokers (from caller)"
}

variable "broker_instance_type" {
  type        = string
  default     = "kafka.t3.small"
  description = "Broker instance type"
}

variable "broker_ebs_volume_size" {
  type        = number
  default     = 1000
  description = "EBS volume size per broker (GB)"
}

variable "broker_ebs_volume_type" {
  type        = string
  default     = "gp3"
  description = "EBS volume type"
}

variable "encryption_in_transit_client_broker" {
  type        = string
  default     = "TLS"
  description = "TLS or PLAINTEXT"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
