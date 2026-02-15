/**
 * VPC module: VPC, public/private subnets, IGW, optional NAT gateway.
 * Equivalent to gcp/network for AWS. No internal module calls.
 * Reference: modules-clone/terraform-aws-vpc
 */

variable "name" {
  type        = string
  description = "Name used for the VPC and related resources"
}

variable "cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "IPv4 CIDR for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "Availability zone names or IDs (e.g. [\"us-east-1a\", \"us-east-1b\"])"
}

variable "public_subnets" {
  type        = list(string)
  default     = []
  description = "List of public subnet CIDRs (one per AZ or repeated)"
}

variable "private_subnets" {
  type        = list(string)
  default     = []
  description = "List of private subnet CIDRs"
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "Enable DNS hostnames in the VPC"
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Enable DNS support in the VPC"
}

variable "enable_nat_gateway" {
  type        = bool
  default     = true
  description = "Create NAT gateway(s) for private subnets"
}

variable "single_nat_gateway" {
  type        = bool
  default     = false
  description = "Use a single NAT gateway for all private subnets (cheaper, less HA)"
}

variable "map_public_ip_on_launch" {
  type        = bool
  default     = true
  description = "Assign public IP to instances launched in public subnets"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags applied to all resources"
}
