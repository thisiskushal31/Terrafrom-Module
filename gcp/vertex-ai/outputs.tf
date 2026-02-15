output "dataset_id" {
  description = "Vertex AI dataset ID"
  value       = var.create_dataset ? google_vertex_ai_dataset.dataset[0].id : null
}

output "dataset_name" {
  description = "Vertex AI dataset name"
  value       = var.create_dataset ? google_vertex_ai_dataset.dataset[0].name : null
}

output "endpoint_id" {
  description = "Vertex AI endpoint ID"
  value       = var.create_endpoint ? google_vertex_ai_endpoint.endpoint[0].id : null
}

output "endpoint_name" {
  description = "Vertex AI endpoint name"
  value       = var.create_endpoint ? google_vertex_ai_endpoint.endpoint[0].name : null
}
