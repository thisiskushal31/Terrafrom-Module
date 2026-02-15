# cloud-function

**Cloud Function only:** zip source, upload to an existing GCS bucket (use **cloud-storage** for the bucket), deploy the function. Event or HTTP trigger.

## Usage

```hcl
module "fn_bucket" {
  source     = "./gcp/cloud-storage"
  project_id = var.project_id
  names      = ["fn-source"]
  location   = var.region
}

module "fn" {
  source      = "./gcp/cloud-function"
  project_id  = var.project_id
  name       = "my-function"
  region     = "us-central1"
  bucket_name = module.fn_bucket.names["fn-source"]
  source_directory = "./functions/my-fn"
  runtime    = "nodejs20"
  entry_point = "myHandler"
  event_trigger = { event_type = "google.pubsub.topic.publish", resource = google_pubsub_topic.topic.name }
}
```

## Inputs

See `variables.tf`. Required: `project_id`, `name`, `region`, `bucket_name`, `source_directory`, `runtime`, `entry_point`. Bucket from **cloud-storage** module.

## Outputs

`function_name`, `function_id`, `https_trigger_url`.
