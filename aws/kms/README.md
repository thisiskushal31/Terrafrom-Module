# AWS KMS Module

Creates a **KMS** key with optional alias. Equivalent to **gcp/kms**. Reference: `modules-clone/terraform-aws-kms`.

## Scope

- `aws_kms_key`, optional `aws_kms_alias`. Default key policy allows account root full access.

## Usage

```hcl
module "kms" {
  source = "./aws/kms"

  description             = "My app encryption key"
  deletion_window_in_days = 7
  enable_key_rotation    = true
  alias                   = "my-key"

  tags = { env = "prod" }
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| description | Key description | `null` |
| deletion_window_in_days | 7-30 | `30` |
| enable_key_rotation | Auto rotation | `true` |
| alias | Display name (alias/name) | `null` |
| tags | Tags | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| key_id | Key ID |
| key_arn | Key ARN |
| alias_name | Alias name if set |
