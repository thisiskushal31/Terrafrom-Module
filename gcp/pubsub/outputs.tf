output "topic" {
  description = "Topic name"
  value       = var.create_topic ? google_pubsub_topic.topic[0].name : var.topic
}

output "topic_id" {
  description = "Topic ID (full name)"
  value       = var.create_topic ? google_pubsub_topic.topic[0].id : ""
}

output "pull_subscription_names" {
  description = "Pull subscription names"
  value       = [for s in google_pubsub_subscription.pull : s.name]
}

output "push_subscription_names" {
  description = "Push subscription names"
  value       = [for s in google_pubsub_subscription.push : s.name]
}
