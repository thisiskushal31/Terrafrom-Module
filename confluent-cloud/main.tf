resource "confluent_environment" "this" {
  display_name = var.environment_display_name

  dynamic "stream_governance" {
    for_each = var.stream_governance_package != null ? [1] : []
    content {
      package = var.stream_governance_package
    }
  }

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
}

resource "confluent_kafka_cluster" "this" {
  display_name  = var.cluster_display_name
  availability  = var.cluster_availability
  cloud         = var.cluster_cloud
  region        = var.cluster_region

  dynamic "basic" {
    for_each = var.cluster_type == "basic" ? [1] : []
    content {}
  }
  dynamic "standard" {
    for_each = var.cluster_type == "standard" ? [1] : []
    content {
      max_ecku = var.cluster_standard_max_ecku
    }
  }
  dynamic "dedicated" {
    for_each = var.cluster_type == "dedicated" ? [1] : []
    content {
      cku = var.cluster_dedicated_cku
    }
  }
  dynamic "enterprise" {
    for_each = var.cluster_type == "enterprise" ? [1] : []
    content {
      max_ecku = var.cluster_standard_max_ecku
    }
  }
  dynamic "freight" {
    for_each = var.cluster_type == "freight" ? [1] : []
    content {
      max_ecku = var.cluster_standard_max_ecku
    }
  }

  environment {
    id = confluent_environment.this.id
  }

  dynamic "network" {
    for_each = var.cluster_network_id != null ? [1] : []
    content {
      id = var.cluster_network_id
    }
  }

  dynamic "byok_key" {
    for_each = var.cluster_byok_key_id != null ? [1] : []
    content {
      id = var.cluster_byok_key_id
    }
  }

  lifecycle {
    prevent_destroy = var.prevent_destroy
  }
}

# Service account and Kafka API key (optional)
resource "confluent_service_account" "this" {
  count        = var.create_service_account ? 1 : 0
  display_name = var.service_account_display_name
  description  = coalesce(var.service_account_description, "Terraform-managed service account for Kafka cluster ${var.cluster_display_name}")
}

# RBAC: role binding for the Kafka cluster (when service_account_cluster_role_name is set)
resource "confluent_role_binding" "cluster" {
  count = var.create_service_account && var.service_account_cluster_role_name != null ? 1 : 0

  principal   = "User:${confluent_service_account.this[0].id}"
  role_name   = var.service_account_cluster_role_name
  crn_pattern = confluent_kafka_cluster.this.rbac_crn
}

# RBAC: additional role bindings (e.g. Schema Registry, other resources)
resource "confluent_role_binding" "additional" {
  for_each = var.create_service_account && length(var.service_account_role_bindings) > 0 ? { for i, b in var.service_account_role_bindings : i => b } : {}

  principal   = "User:${confluent_service_account.this[0].id}"
  role_name   = each.value.role_name
  crn_pattern = each.value.crn_pattern
}

resource "confluent_api_key" "kafka" {
  count        = var.create_service_account ? 1 : 0
  display_name = "${var.cluster_display_name}-api-key"
  description  = "Kafka API key for ${var.service_account_display_name}"

  owner {
    id          = confluent_service_account.this[0].id
    api_version = confluent_service_account.this[0].api_version
    kind        = confluent_service_account.this[0].kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.this.id
    api_version = confluent_kafka_cluster.this.api_version
    kind        = confluent_kafka_cluster.this.kind
    environment {
      id = confluent_environment.this.id
    }
  }
}

# Kafka topics (optional)
resource "confluent_kafka_topic" "this" {
  for_each = var.create_service_account && length(var.create_topics) > 0 ? toset(var.create_topics) : toset([])

  kafka_cluster {
    id = confluent_kafka_cluster.this.id
  }
  topic_name         = each.key
  partitions_count   = var.topic_partitions_count
  rest_endpoint      = confluent_kafka_cluster.this.rest_endpoint
  config             = var.topic_config
  credentials {
    key    = confluent_api_key.kafka[0].id
    secret = confluent_api_key.kafka[0].secret
  }
}
