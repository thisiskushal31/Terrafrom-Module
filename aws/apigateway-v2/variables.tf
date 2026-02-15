variable "name" {
  type        = string
  description = "Name of the API"
}

variable "protocol_type" {
  type        = string
  default     = "HTTP"
  description = "HTTP or WEBSOCKET"
}

variable "description" {
  type        = string
  default     = null
  description = "API description"
}

variable "integration_uri" {
  type        = string
  default     = null
  description = "Lambda invoke ARN or HTTP endpoint for default integration"
}

variable "integration_type" {
  type        = string
  default     = "AWS_PROXY"
  description = "AWS_PROXY, HTTP_PROXY, or HTTP"
}

variable "integration_method" {
  type        = string
  default     = "POST"
  description = "HTTP method for integration"
}

variable "payload_format_version" {
  type        = string
  default     = "2.0"
  description = "1.0 or 2.0 for Lambda"
}

variable "route_key" {
  type        = string
  default     = "ANY /{proxy+}"
  description = "Route key (e.g. ANY /{proxy+} for catch-all); null = no default route"
}

variable "create_default_stage" {
  type        = bool
  default     = true
  description = "Create default $default stage"
}

variable "stage_name" {
  type        = string
  default     = "$default"
  description = "Stage name when create_default_stage is true"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}
