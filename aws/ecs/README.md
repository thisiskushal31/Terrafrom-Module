# ecs

Creates an ECS cluster and optionally an ECS service (Fargate or EC2). Use for container workloads without Kubernetes. Caller provides task definition ARN; optionally attach to ALB/NLB via target_group_arn.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| cluster_name | Cluster name | required |
| task_definition_arn | Task def ARN (null = cluster only) | null |
| service_name | Service name (when service created) | null |
| desired_count | Desired tasks | 1 |
| subnet_ids, security_group_ids | For service | null, [] |
| target_group_arn | ALB/NLB target group | null |
| tags | Tags | {} |

## Outputs

- **cluster_id**, **cluster_arn**, **service_id**, **service_arn**
