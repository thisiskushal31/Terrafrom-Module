output "name" {
  description = "Parameter name"
  value       = var.ignore_value_changes ? aws_ssm_parameter.ignore_value[0].name : aws_ssm_parameter.this[0].name
}

output "arn" {
  description = "Parameter ARN"
  value       = var.ignore_value_changes ? aws_ssm_parameter.ignore_value[0].arn : aws_ssm_parameter.this[0].arn
}

output "version" {
  description = "Parameter version"
  value       = var.ignore_value_changes ? aws_ssm_parameter.ignore_value[0].version : aws_ssm_parameter.this[0].version
}
