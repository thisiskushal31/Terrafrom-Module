# msk

Creates an Amazon MSK (Managed Streaming for Apache Kafka) cluster. Use for event streaming. Caller provides subnets and security groups.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| cluster_name | Cluster name | required |
| kafka_version | e.g. 3.5.1 | required |
| number_of_broker_nodes | Broker count | required |
| subnet_ids, security_group_ids | From caller | required |
| broker_instance_type | Broker instance type | kafka.t3.small |
| broker_ebs_volume_size | EBS size per broker (GB) | 1000 |
| tags | Tags | {} |

## Outputs

- **cluster_arn**, **cluster_name**, **bootstrap_brokers** (sensitive), **bootstrap_brokers_sasl_iam** (sensitive)
