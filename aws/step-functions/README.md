# step-functions

Creates an AWS Step Functions state machine. Use for workflow orchestration, ETL, and event-driven pipelines. Caller provides IAM role and definition (JSON).

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | State machine name | required |
| role_arn | IAM role ARN (caller) | required |
| definition | Definition JSON string | required |
| type | STANDARD or EXPRESS | STANDARD |
| tags | Tags | {} |

## Outputs

- **state_machine_arn**, **state_machine_id**
