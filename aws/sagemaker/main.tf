resource "aws_sagemaker_notebook_instance" "this" {
  name                   = var.name
  instance_type          = var.instance_type
  role_arn               = var.role_arn
  subnet_id              = var.subnet_id
  security_groups        = var.security_group_ids
  direct_internet_access = var.direct_internet_access
  volume_size_in_gb      = var.volume_size_in_gb
  kms_key_id             = var.kms_key_id
  lifecycle_config_name   = var.lifecycle_config_name
  default_code_repository = var.default_code_repository
  root_access             = var.root_access
  platform_identifier     = var.platform_identifier
  tags                    = var.tags
}
