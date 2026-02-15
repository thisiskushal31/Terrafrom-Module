# security-group

Creates an AWS security group with configurable ingress and egress rules. Use for EC2, RDS, ALB, Lambda (VPC), EKS node groups, ElastiCache, and similar resources.

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | Name of the security group | required |
| description | Description | `"Managed by Terraform"` |
| vpc_id | VPC ID (e.g. from aws/vpc) | required |
| ingress_rules | List of { from_port, to_port, protocol, cidr_blocks?, source_security_group_id?, description? } | `[]` |
| egress_rules | List of egress rules; default [] = no egress | `[]` |
| revoke_rules_on_delete | Revoke rules before delete (e.g. EMR) | `false` |
| tags | Tags | `{}` |

## Outputs

- **security_group_id** — Pass to EC2, RDS, ALB, etc.
- **security_group_arn**

## Example

```hcl
module "sg_web" {
  source   = "./aws/security-group"
  name     = "web-sg"
  vpc_id   = module.vpc.vpc_id
  ingress_rules = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTP" },
    { from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"], description = "HTTPS" }
  ]
  egress_rules = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
}
```
