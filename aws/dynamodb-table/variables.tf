variable "name" {
  type        = string
  description = "Table name"
}

variable "hash_key" {
  type        = string
  description = "Hash key attribute name"
}

variable "range_key" {
  type        = string
  default     = null
  description = "Range key attribute name"
}

variable "attributes" {
  type = list(object({
    name = string
    type = string
  }))
  description = "List of attribute { name, type (S/N/B) }"
}

variable "billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "PAY_PER_REQUEST or PROVISIONED"
}

variable "read_capacity" {
  type        = number
  default     = null
  description = "Read capacity when PROVISIONED"
}

variable "write_capacity" {
  type        = number
  default     = null
  description = "Write capacity when PROVISIONED"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
