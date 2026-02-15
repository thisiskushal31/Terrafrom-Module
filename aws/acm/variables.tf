variable "domain_name" {
  type        = string
  description = "Primary domain name for the certificate"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
  description = "Additional SANs (e.g. *.example.com)"
}

variable "validation_method" {
  type        = string
  default     = "DNS"
  description = "DNS or EMAIL"
}

variable "key_algorithm" {
  type        = string
  default     = "RSA_2048"
  description = "RSA_2048 or EC_prime256v1"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
