variable "zone_name" {
  type        = string
  description = "Domain name for the hosted zone (e.g. example.com)"
}

variable "comment" {
  type        = string
  default     = null
  description = "Comment for the zone"
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "Allow destroy even if records exist"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the zone"
}
