resource "aws_msk_cluster" "this" {
  cluster_name           = var.cluster_name
  kafka_version         = var.kafka_version
  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    client_subnets  = var.subnet_ids
    security_groups = var.security_group_ids
    storage_info {
      ebs_storage_info {
        volume_size = var.broker_ebs_volume_size
        volume_type = var.broker_ebs_volume_type
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = var.encryption_in_transit_client_broker
      in_cluster   = true
    }
  }

  tags = var.tags
}
