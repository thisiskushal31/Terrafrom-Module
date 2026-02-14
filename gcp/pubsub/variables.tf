variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "topic" {
  type        = string
  description = "Topic name"
}

variable "create_topic" {
  type        = bool
  default     = true
  description = "Create the topic"
}

variable "topic_labels" {
  type        = map(string)
  default     = {}
  description = "Topic labels"
}

variable "pull_subscriptions" {
  type = list(object({
    name                         = string
    ack_deadline_seconds         = optional(number)
    message_retention_duration   = optional(string)
    retain_acked_messages        = optional(bool)
    expiration_policy_ttl        = optional(string)
    filter                       = optional(string)
    labels                       = optional(map(string))
    dead_letter_topic            = optional(string)
    max_delivery_attempts        = optional(number)
  }))
  default     = []
  description = "Pull subscriptions"
}

variable "push_subscriptions" {
  type = list(object({
    name                    = string
    push_endpoint           = string
    ack_deadline_seconds    = optional(number)
    oidc_service_account_email = optional(string)
    oidc_audience           = optional(string)
    expiration_policy_ttl   = optional(string)
    filter                  = optional(string)
    labels                  = optional(map(string))
  }))
  default     = []
  description = "Push subscriptions"
}
