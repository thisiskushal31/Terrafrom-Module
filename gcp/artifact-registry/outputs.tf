output "repository_id" {
  description = "Repository ID"
  value       = google_artifact_registry_repository.repo.repository_id
}

output "name" {
  description = "Full repository name (projects/PROJECT/locations/LOC/repositories/ID)"
  value       = google_artifact_registry_repository.repo.name
}
