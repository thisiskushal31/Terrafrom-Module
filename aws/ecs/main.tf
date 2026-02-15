resource "aws_ecs_cluster" "this" {
  name = var.cluster_name
  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }
  tags = var.tags
}

resource "aws_ecs_service" "this" {
  count = var.task_definition_arn != null ? 1 : 0

  name            = coalesce(var.service_name, "${var.cluster_name}-svc")
  cluster         = aws_ecs_cluster.this.id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  dynamic "network_configuration" {
    for_each = var.subnet_ids != null ? [1] : []
    content {
      subnets          = var.subnet_ids
      security_groups  = var.security_group_ids
      assign_public_ip = var.assign_public_ip
    }
  }

  dynamic "load_balancer" {
    for_each = var.target_group_arn != null ? [1] : []
    content {
      target_group_arn = var.target_group_arn
      container_name  = var.load_balancer_container_name
      container_port  = var.load_balancer_container_port
    }
  }

  deployment_minimum_healthy_percent = var.deployment_minimum_healthy_percent
  deployment_maximum_percent        = var.deployment_maximum_percent
  enable_execute_command            = var.enable_execute_command

  tags = var.tags
}
