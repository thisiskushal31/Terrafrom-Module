/**
 * Standalone module: Pub/Sub topic and subscriptions (push/pull).
 * Only google_pubsub_topic and google_pubsub_subscription—no module calls.
 */

resource "google_pubsub_topic" "topic" {
  count = var.create_topic ? 1 : 0

  project = var.project_id
  name    = var.topic
  labels  = var.topic_labels
}

resource "google_pubsub_subscription" "pull" {
  for_each = { for s in var.pull_subscriptions : s.name => s }

  project = var.project_id
  name    = each.value.name
  topic   = var.create_topic ? google_pubsub_topic.topic[0].name : var.topic

  ack_deadline_seconds       = try(each.value.ack_deadline_seconds, 10)
  message_retention_duration = try(each.value.message_retention_duration, null)
  retain_acked_messages      = try(each.value.retain_acked_messages, false)
  dynamic "expiration_policy" {
    for_each = try(each.value.expiration_policy_ttl, null) != null && each.value.expiration_policy_ttl != "" ? [1] : []
    content {
      ttl = each.value.expiration_policy_ttl
    }
  }
  filter = try(each.value.filter, null)
  labels = try(each.value.labels, null)

  dynamic "dead_letter_policy" {
    for_each = try(each.value.dead_letter_topic, null) != null ? [1] : []
    content {
      dead_letter_topic     = each.value.dead_letter_topic
      max_delivery_attempts = try(each.value.max_delivery_attempts, 5)
    }
  }
}

resource "google_pubsub_subscription" "push" {
  for_each = { for s in var.push_subscriptions : s.name => s }

  project = var.project_id
  name    = each.value.name
  topic   = var.create_topic ? google_pubsub_topic.topic[0].name : var.topic

  ack_deadline_seconds = try(each.value.ack_deadline_seconds, 10)
  push_config {
    push_endpoint = each.value.push_endpoint
    dynamic "oidc_token" {
      for_each = try(each.value.oidc_service_account_email, null) != null ? [1] : []
      content {
        service_account_email = each.value.oidc_service_account_email
        audience              = try(each.value.oidc_audience, null)
      }
    }
  }
  dynamic "expiration_policy" {
    for_each = try(each.value.expiration_policy_ttl, null) != null && each.value.expiration_policy_ttl != "" ? [1] : []
    content {
      ttl = each.value.expiration_policy_ttl
    }
  }
  filter = try(each.value.filter, null)
  labels = try(each.value.labels, null)
}
