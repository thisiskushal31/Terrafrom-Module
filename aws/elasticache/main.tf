resource "aws_elasticache_subnet_group" "this" {
  count = var.subnet_group_name == null ? 1 : 0

  name       = "${var.replication_group_id}-sg"
  subnet_ids = var.subnet_ids
  description = "Subnet group for ${var.replication_group_id}"
}

locals {
  subnet_group_name = coalesce(var.subnet_group_name, try(aws_elasticache_subnet_group.this[0].name, null))
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id = var.replication_group_id
  description          = coalesce(var.description, "Redis replication group")
  engine               = var.engine
  engine_version       = var.engine_version
  node_type            = var.node_type
  num_cache_clusters   = var.num_cache_clusters
  port                 = var.port

  subnet_group_name  = local.subnet_group_name
  security_group_ids = var.security_group_ids

  at_rest_encryption_enabled = var.at_rest_encryption_enabled
  transit_encryption_enabled = var.transit_encryption_enabled
  kms_key_id                 = var.at_rest_encryption_enabled ? var.kms_key_id : null
  auth_token                 = var.auth_token

  automatic_failover_enabled = var.num_cache_clusters > 1 ? true : var.automatic_failover_enabled
  multi_az_enabled          = var.multi_az_enabled

  snapshot_retention_limit = var.snapshot_retention_limit
  snapshot_window          = var.snapshot_window
  maintenance_window       = var.maintenance_window

  tags = var.tags
}
