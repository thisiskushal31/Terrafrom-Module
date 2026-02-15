output "cluster_id" {
  description = "ECS cluster ID"
  value       = aws_ecs_cluster.this.id
}

output "cluster_arn" {
  description = "ECS cluster ARN"
  value       = aws_ecs_cluster.this.arn
}

output "service_id" {
  description = "ECS service ID (when service is created)"
  value       = try(aws_ecs_service.this[0].id, null)
}

output "service_arn" {
  description = "ECS service ARN (when service is created)"
  value       = try(aws_ecs_service.this[0].arn, null)
}
