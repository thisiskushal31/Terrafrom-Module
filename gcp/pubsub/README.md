# pubsub

Standalone module: **Pub/Sub** topic and pull/push subscriptions. Only GCP resources here—no external module calls.

## Usage

```hcl
module "pubsub" {
  source     = "./gcp/pubsub"
  project_id = var.project_id
  topic      = "my-topic"
  pull_subscriptions = [
    { name = "my-pull", ack_deadline_seconds = 20 },
  ]
}
```

## Inputs

| Name | Description | Default |
|------|-------------|---------|
| project_id | Project ID | required |
| topic | Topic name | required |
| create_topic | Create topic | `true` |
| pull_subscriptions | Pull subscription list | `[]` |
| push_subscriptions | Push subscription list | `[]` |

## Outputs

- `topic`, `topic_id`, `pull_subscription_names`, `push_subscription_names`
