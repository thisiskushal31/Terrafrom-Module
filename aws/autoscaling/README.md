# autoscaling

Creates an Auto Scaling group. Use with a launch template (from caller) and optionally ALB/NLB target groups. Scale EC2 behind load balancers.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | ASG name | required |
| min_size, max_size, desired_capacity | Capacity | 0, required, null |
| subnet_ids | Subnets for instances | required |
| launch_template_id | Launch template (caller) | required |
| target_group_arns | ALB/NLB target groups | [] |
| health_check_type | EC2 or ELB | EC2 |
| tags | Tags | {} |

## Outputs

- **autoscaling_group_name**, **autoscaling_group_arn**
