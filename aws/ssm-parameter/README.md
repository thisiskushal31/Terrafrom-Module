# ssm-parameter

Creates an SSM Parameter Store parameter (String, StringList, or SecureString). Use for config and secrets; complements secrets-manager.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | Parameter name (path with /) | required |
| type | String, StringList, SecureString | required |
| value | Value (String/StringList) | — |
| value_secure | Value for SecureString | — |
| key_id | KMS key for SecureString | null |
| ignore_value_changes | Ignore value in lifecycle | false |
| tags | Tags | {} |

## Outputs

- **name**, **arn**, **version**
