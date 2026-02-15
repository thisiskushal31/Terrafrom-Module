resource "aws_autoscaling_group" "this" {
  name                = var.name
  min_size            = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.subnet_ids
  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }
  health_check_type         = var.health_check_type
  health_check_grace_period  = var.health_check_grace_period
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  enabled_metrics           = length(var.enabled_metrics) > 0 ? var.enabled_metrics : null
  protect_from_scale_in     = var.protect_from_scale_in

  tags = [for k, v in merge(var.tags, { "Name" = var.name }) : { key = k, value = v, propagate_at_launch = true }]
}
