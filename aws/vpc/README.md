# AWS VPC Module

Creates a **VPC** with optional public and private subnets, Internet Gateway, and NAT gateway(s). Equivalent to **gcp/network** for AWS. Reference: `modules-clone/terraform-aws-vpc`.

## Scope

- `aws_vpc`, `aws_subnet` (public/private), `aws_internet_gateway`, `aws_nat_gateway`, `aws_route_table`, `aws_route`, `aws_route_table_association`, `aws_eip`
- No security groups or NACLs in this module (use **security-group** or separate module)

## Usage

```hcl
module "vpc" {
  source = "./aws/vpc"

  name   = "my-vpc"
  cidr   = "10.0.0.0/16"
  azs    = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = false

  tags = { env = "prod" }
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| name | Name for VPC and resources | required |
| cidr | VPC CIDR | `10.0.0.0/16` |
| azs | Availability zones | required |
| public_subnets | Public subnet CIDRs | `[]` |
| private_subnets | Private subnet CIDRs | `[]` |
| enable_nat_gateway | Create NAT gateway(s) | `true` |
| single_nat_gateway | One NAT for all private subnets | `false` |
| map_public_ip_on_launch | Public IP on launch in public subnets | `true` |
| tags | Tags | `{}` |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| vpc_cidr_block | VPC CIDR |
| public_subnet_ids | Public subnet IDs |
| private_subnet_ids | Private subnet IDs |
| internet_gateway_id | IGW ID |
| nat_gateway_ids | NAT gateway IDs |
