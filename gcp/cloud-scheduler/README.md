# cloud-scheduler

Create a **Cloud Scheduler** job that triggers on a cron schedule. Supports **HTTP** (e.g. invoke Cloud Run or a URL) or **Pub/Sub** targets.

## Usage

```hcl
# HTTP target (e.g. Cloud Run)
module "scheduler" {
  source     = "./gcp/cloud-scheduler"
  project_id = var.project_id
  name       = "daily-job"
  region     = "us-central1"
  schedule   = "0 9 * * *"
  target_type = "http"
  http_uri   = "https://my-run-xxx.run.app"
  oidc_service_account_email = google_service_account.invoker.email
}

# Pub/Sub target
module "scheduler_pubsub" {
  source     = "./gcp/cloud-scheduler"
  project_id = var.project_id
  name       = "pubsub-job"
  region     = "us-central1"
  schedule   = "*/5 * * * *"
  target_type = "pubsub"
  pubsub_topic_name = google_pubsub_topic.topic.id
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`, `region`, `schedule`, `target_type`. For HTTP: `http_uri`. For Pub/Sub: `pubsub_topic_name`.

## Outputs

`job_id`, `name`.
