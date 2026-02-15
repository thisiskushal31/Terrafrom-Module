output "environment_id" {
  description = "Composer environment ID"
  value       = google_composer_environment.env.id
}

output "environment_name" {
  description = "Environment name"
  value       = google_composer_environment.env.name
}

output "gcs_dag_bucket" {
  description = "GCS bucket for DAGs"
  value       = google_composer_environment.env.config.0.dag_gcs_prefix
}

output "airflow_uri" {
  description = "Airflow web UI URI"
  value       = google_composer_environment.env.config.0.airflow_uri
}
