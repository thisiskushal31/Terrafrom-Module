/**
 * Standalone Vertex AI: dataset and/or endpoint.
 * Only google_* — no module calls.
 */

resource "google_vertex_ai_dataset" "dataset" {
  count               = var.create_dataset ? 1 : 0
  project             = var.project_id
  display_name        = var.dataset_display_name
  metadata_schema_uri = var.dataset_metadata_schema_uri
  region              = var.region
  labels              = var.dataset_labels
}

resource "google_vertex_ai_endpoint" "endpoint" {
  count         = var.create_endpoint ? 1 : 0
  project       = var.project_id
  name          = var.endpoint_name
  display_name  = var.endpoint_display_name
  description   = var.endpoint_description
  location      = var.region
  labels        = var.endpoint_labels
}
