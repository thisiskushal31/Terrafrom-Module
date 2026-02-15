# sagemaker

Creates a **SageMaker Notebook Instance** for ML development (Jupyter). Use for experimentation, training scripts, and model development. IAM role, subnet, and security groups are provided by the caller.

For **SageMaker Studio** (Domain), **endpoints** (inference), or **training jobs**, use the [Terraform Registry](https://registry.terraform.io/search/modules?provider=aws&q=sagemaker) or extend this module.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | Notebook instance name | required |
| instance_type | e.g. ml.t3.medium, ml.p2.xlarge | ml.t3.medium |
| role_arn | IAM role ARN (SageMaker + VPC/EC2 as needed) | required |
| subnet_id | Subnet for the instance | required |
| security_group_ids | Security groups | required |
| direct_internet_access | Allow internet (false for VPC-only) | true |
| volume_size_in_gb | EBS size (GB) | 5 |
| kms_key_id | KMS for volume encryption | null |
| lifecycle_config_name | Lifecycle config for on-create/start | null |
| tags | Tags | {} |

## Outputs

- **notebook_instance_arn**, **notebook_instance_name**, **notebook_instance_url**

## Example

```hcl
module "sagemaker" {
  source = "./aws/sagemaker"
  name   = "my-ml-notebook"
  role_arn          = aws_iam_role.sagemaker.arn
  subnet_id         = module.vpc.private_subnet_ids[0]
  security_group_ids = [module.sg_sagemaker.security_group_id]
  instance_type     = "ml.t3.medium"
}
```
