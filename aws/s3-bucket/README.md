# AWS S3 Bucket Module

Creates an **S3** bucket with optional versioning. Equivalent to **gcp/cloud-storage** (GCS). Reference: `modules-clone/terraform-aws-s3-bucket`.

## Scope

- `aws_s3_bucket`, optional `aws_s3_bucket_versioning`
- No bucket policy, ACL, or logging in this module (extend or use separate resources)

## Usage

```hcl
module "bucket" {
  source = "./aws/s3-bucket"

  bucket        = "my-app-bucket-unique-name"
  force_destroy = false
  versioning    = { enabled = true }
  tags          = { env = "prod" }
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| bucket | Bucket name (globally unique) | required |
| bucket_prefix | Prefix to generate name | `null` |
| force_destroy | Allow destroy with objects | `false` |
| versioning | `{ enabled = bool }` | `{}` |
| tags | Tags | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| s3_bucket_id | Bucket name |
| s3_bucket_arn | Bucket ARN |
| s3_bucket_bucket_domain_name | Bucket domain name |
| s3_bucket_bucket_regional_domain_name | Regional domain name |
