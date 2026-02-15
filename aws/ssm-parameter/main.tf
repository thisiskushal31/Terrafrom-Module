resource "aws_ssm_parameter" "this" {
  count = var.ignore_value_changes ? 0 : 1

  name  = var.name
  type  = var.type
  value = var.value

  description      = var.description
  key_id           = var.type == "SecureString" ? var.key_id : null
  overwrite        = var.overwrite
  tier             = var.tier
  allowed_pattern  = var.allowed_pattern
  data_type        = var.data_type

  tags = var.tags
}

resource "aws_ssm_parameter" "ignore_value" {
  count = var.ignore_value_changes ? 1 : 0

  name  = var.name
  type  = var.type
  value = var.value

  description      = var.description
  key_id           = var.type == "SecureString" ? var.key_id : null
  overwrite        = var.overwrite
  tier             = var.tier
  allowed_pattern  = var.allowed_pattern
  data_type        = var.data_type

  tags = var.tags

  lifecycle {
    ignore_changes = [value]
  }
}
