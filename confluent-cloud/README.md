# Confluent Cloud module

A Terraform module for **Confluent Cloud** (managed Kafka and event streaming). It creates an **Environment**, a **Kafka cluster** (in the cloud and region you choose), optional **Stream Governance** (Schema Registry), **service account**, **Kafka API key**, and **topics**. Uses the [confluentinc/confluent](https://registry.terraform.io/providers/confluentinc/confluent/latest) provider.

The Confluent provider does not split by cloud: you use the same resources and set **cloud** (AWS, AZURE, or GCP) and **region** on the Kafka cluster. This module is a single entry point; you pass `cluster_cloud` and `cluster_region` as variables.

**Prerequisites:** Confluent Cloud account; `CONFLUENT_CLOUD_API_KEY` and `CONFLUENT_CLOUD_API_SECRET` (or provider config).

---

## What this module creates

- **Environment** – Confluent environment (optional Stream Governance: ESSENTIALS or ADVANCED).
- **Kafka cluster** – One cluster; you choose `cluster_cloud`, `cluster_region`, and type (basic, standard, dedicated, enterprise, freight). Optional private networking (`cluster_network_id`) and BYOK encryption (`cluster_byok_key_id`).
- **Service account + Kafka API key** – Optional; needed to create topics or for client access.
- **RBAC role bindings** – Optional; grant the service account roles on the cluster and/or other resources (e.g. Schema Registry) via `service_account_cluster_role_name` and `service_account_role_bindings`.
- **Topics** – Optional list of topic names with config (e.g. `retention.ms`, `cleanup.policy`) via `topic_config`; created only when `create_service_account` is true.

---

## How to use

```hcl
terraform {
  required_providers {
    confluent = { source = "confluentinc/confluent", version = ">= 1.0" }
  }
}

module "confluent_cloud" {
  source = "./confluent-cloud"

  environment_display_name = "my-env"
  cluster_display_name   = "my-kafka"
  cluster_cloud          = "AWS"        # or AZURE, GCP
  cluster_region         = "us-east-1"
  cluster_availability   = "SINGLE_ZONE"
  cluster_type           = "basic"

  stream_governance_package = "ESSENTIALS"   # optional

  create_service_account           = true
  service_account_cluster_role_name = "Operator"   # RBAC role on the Kafka cluster (e.g. Operator, CloudClusterAdmin)
  create_topics                    = ["orders", "events"]
}
```

---

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| environment_display_name | Environment display name | required |
| stream_governance_package | ESSENTIALS or ADVANCED | null |
| cluster_display_name | Kafka cluster display name | required |
| cluster_cloud | AWS, AZURE, or GCP | AWS |
| cluster_region | Cluster region (e.g. us-east-1, centralus, us-central1) | required |
| cluster_availability | SINGLE_ZONE, MULTI_ZONE, LOW, HIGH | SINGLE_ZONE |
| cluster_type | basic, standard, dedicated, enterprise, freight | basic |
| cluster_dedicated_cku | CKUs for dedicated type | 2 |
| cluster_standard_max_ecku | Max eCKUs for standard/enterprise/freight | null |
| cluster_network_id | Confluent Network ID for private networking | null |
| cluster_byok_key_id | BYOK key ID for cluster encryption at rest | null |
| create_service_account | Create SA and Kafka API key | false |
| service_account_display_name | Service account name | terraform-managed-sa |
| service_account_description | Service account description | null |
| service_account_cluster_role_name | RBAC role on the Kafka cluster (e.g. Operator, CloudClusterAdmin, DeveloperRead) | null |
| service_account_role_bindings | List of { role_name, crn_pattern } for additional RBAC bindings | [] |
| create_topics | List of topic names to create | [] |
| topic_partitions_count | Partitions per topic | 6 |
| topic_config | Topic config for all created topics (e.g. retention.ms, cleanup.policy) | {} |
| prevent_destroy | Lifecycle prevent_destroy on env/cluster | false |

---

## Outputs

| Name | Description |
|------|-------------|
| environment_id | Confluent environment ID |
| kafka_cluster_id | Kafka cluster ID |
| bootstrap_endpoint | Kafka bootstrap endpoint |
| rest_endpoint | Kafka REST endpoint |
| rbac_crn | Kafka cluster RBAC CRN |
| kafka_cluster_api_version | Cluster API version (e.g. cmk/v2) |
| kafka_cluster_kind | Cluster kind (e.g. Cluster) |
| service_account_id | Service account ID (if created) |
| service_account_api_version | Service account API version (if created) |
| service_account_kind | Service account kind (if created) |
| kafka_api_key_id | Kafka API key ID (if created) |
| kafka_api_key_secret | Kafka API key secret (sensitive) |
| topic_ids | Map of topic name to ID |

---

## Scope

This module covers **core Kafka on Confluent Cloud**: environment, cluster (all types), private networking, BYOK, Stream Governance, service account, RBAC, API key, and topics with config. Other Confluent Cloud features—ksqlDB, Flink, Connectors, Kafka ACLs, dedicated-cluster broker config (`confluent_kafka_cluster_config`), cluster linking, mirror topics—can be added in separate Terraform using the same [Confluent provider](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs).

---

## Reference

- [Create a Kafka Cluster on Confluent Cloud from a Template Using Terraform](https://docs.confluent.io/cloud/current/clusters/terraform-provider.html)
- [Confluent Terraform Provider (registry)](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs)
