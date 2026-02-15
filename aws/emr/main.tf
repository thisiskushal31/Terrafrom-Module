resource "aws_emr_cluster" "this" {
  name          = var.name
  release_label = var.release_label
  service_role  = var.service_role_arn
  applications  = ["Spark"]

  ec2_attributes {
    subnet_id = var.subnet_id
  }

  master_instance_group {
    instance_type = var.instance_type
  }

  core_instance_group {
    instance_type  = var.instance_type
    instance_count = var.instance_count_core
  }

  tags = var.tags
}
