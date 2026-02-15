# AWS EC2 Instance Module

Creates a single **EC2** instance. Equivalent to **gcp/compute-engine-instance**. Reference: `modules-clone/terraform-aws-ec2-instance`.

## Scope

- `aws_instance` only. Subnet and security groups from caller (e.g. **vpc**, **security-group**).

## Usage

```hcl
module "vm" {
  source = "./aws/ec2-instance"

  name       = "my-vm"
  ami        = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.micro"
  subnet_id  = module.vpc.private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = { env = "prod" }
}
```

## Inputs

| Name | Description |
|------|-------------|
| name | Instance Name tag |
| ami | AMI ID |
| instance_type | Instance type |
| subnet_id | Subnet ID |
| associate_public_ip_address | Assign public IP |
| key_name | SSH key pair name |
| vpc_security_group_ids | Security group IDs |
| tags | Tags |

## Outputs

| Name | Description |
|------|-------------|
| id | Instance ID |
| arn | Instance ARN |
| private_ip | Private IP |
| public_ip | Public IP |
