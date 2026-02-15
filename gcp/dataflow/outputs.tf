output "job_id" {
  description = "Dataflow job ID"
  value       = var.use_flex_template ? google_dataflow_flex_template_job.job[0].id : google_dataflow_job.job[0].id
}

output "job_state" {
  description = "Current state of the job"
  value       = var.use_flex_template ? google_dataflow_flex_template_job.job[0].state : google_dataflow_job.job[0].state
}
