resource "aws_redshift_subnet_group" "this" {
  count = var.subnet_group_name == null ? 1 : 0

  name       = "${var.cluster_identifier}-sg"
  subnet_ids = var.subnet_ids
  description = "Subnet group for ${var.cluster_identifier}"
}

locals {
  subnet_group_name = coalesce(var.subnet_group_name, try(aws_redshift_subnet_group.this[0].name, null))
}

resource "aws_redshift_cluster" "this" {
  cluster_identifier  = var.cluster_identifier
  node_type          = var.node_type
  number_of_nodes    = var.number_of_nodes
  database_name      = var.database_name
  master_username    = var.master_username
  master_password    = var.master_password
  port               = var.port
  cluster_subnet_group_name = local.subnet_group_name
  vpc_security_group_ids   = var.security_group_ids
  publicly_accessible      = var.publicly_accessible
  skip_final_snapshot      = var.skip_final_snapshot
  final_snapshot_identifier = var.skip_final_snapshot ? null : coalesce(var.final_snapshot_identifier, "${var.cluster_identifier}-final")
  tags = var.tags
}
