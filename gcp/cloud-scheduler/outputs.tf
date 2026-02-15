output "job_id" {
  description = "Scheduler job ID"
  value       = google_cloud_scheduler_job.job.id
}

output "name" {
  description = "Job name"
  value       = google_cloud_scheduler_job.job.name
}
