output "environment_id" {
  description = "Confluent Cloud environment ID"
  value       = confluent_environment.this.id
}

output "kafka_cluster_id" {
  description = "Kafka cluster ID"
  value       = confluent_kafka_cluster.this.id
}

output "bootstrap_endpoint" {
  description = "Kafka bootstrap endpoint (SASL_SSL)"
  value       = confluent_kafka_cluster.this.bootstrap_endpoint
}

output "rest_endpoint" {
  description = "Kafka REST endpoint"
  value       = confluent_kafka_cluster.this.rest_endpoint
}

output "rbac_crn" {
  description = "Kafka cluster RBAC CRN"
  value       = confluent_kafka_cluster.this.rbac_crn
}

output "kafka_cluster_api_version" {
  description = "Kafka cluster API version (e.g. cmk/v2)"
  value       = confluent_kafka_cluster.this.api_version
}

output "kafka_cluster_kind" {
  description = "Kafka cluster kind (e.g. Cluster)"
  value       = confluent_kafka_cluster.this.kind
}

output "service_account_id" {
  description = "Created service account ID (if create_service_account is true)"
  value       = var.create_service_account ? confluent_service_account.this[0].id : null
}

output "service_account_api_version" {
  description = "Service account API version (e.g. iam/v2) if created"
  value       = var.create_service_account ? confluent_service_account.this[0].api_version : null
}

output "service_account_kind" {
  description = "Service account kind (e.g. ServiceAccount) if created"
  value       = var.create_service_account ? confluent_service_account.this[0].kind : null
}

output "kafka_api_key_id" {
  description = "Kafka API key ID (if create_service_account is true)"
  value       = var.create_service_account ? confluent_api_key.kafka[0].id : null
}

output "kafka_api_key_secret" {
  description = "Kafka API key secret (if create_service_account is true)"
  value       = var.create_service_account ? confluent_api_key.kafka[0].secret : null
  sensitive   = true
}

output "topic_ids" {
  description = "Map of topic name to topic ID (cluster_id/topic_name)"
  value       = var.create_service_account && length(var.create_topics) > 0 ? { for k, v in confluent_kafka_topic.this : k => v.id } : {}
}
