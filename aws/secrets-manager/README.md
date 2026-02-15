# AWS Secrets Manager Module

Creates a **Secrets Manager** secret with optional initial value. Equivalent to **gcp/secret-manager**. Reference: `modules-clone/terraform-aws-secrets-manager`.

## Scope

- `aws_secretsmanager_secret`, optional `aws_secretsmanager_secret_version` (when secret_string is set).

## Usage

```hcl
module "secret" {
  source = "./aws/secrets-manager"

  name        = "my-app/db-password"
  description = "DB credentials"
  secret_string = "optional-initial-value"
  kms_key_id  = module.kms.key_arn

  tags = { env = "prod" }
}
```

## Inputs

| Name | Description |
|------|-------------|
| name | Secret name |
| description | Description |
| secret_string | Initial value (omit to set later) |
| kms_key_id | KMS key for encryption |
| recovery_window_in_days | 0, 7-30 |
| tags | Tags |

## Outputs

| Name | Description |
|------|-------------|
| secret_id | Secret ID |
| secret_arn | Secret ARN |
| secret_name | Secret name |
