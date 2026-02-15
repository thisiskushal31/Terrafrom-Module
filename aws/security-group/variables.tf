variable "name" {
  type        = string
  description = "Name of the security group"
}

variable "description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Description of the security group"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID (e.g. from aws/vpc)"
}

variable "revoke_rules_on_delete" {
  type        = bool
  default     = false
  description = "Revoke rules before deleting the security group (set true for EMR)"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), [])
    source_security_group_id = optional(string, null)
    description = optional(string, null)
  }))
  default     = []
  description = "List of ingress rules. Omit cidr_blocks to use 0.0.0.0/0 for 'all' style rules; use source_security_group_id for SG-to-SG."
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), ["0.0.0.0/0"])
    description = optional(string, null)
  }))
  default     = []
  description = "List of egress rules. Default empty allows no egress; add one rule with cidr_blocks = [\"0.0.0.0/0\"] for full outbound."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the security group"
}
