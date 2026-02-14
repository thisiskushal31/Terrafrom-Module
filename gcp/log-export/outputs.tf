locals {
  sink_writer = local.is_project ? (length(google_logging_project_sink.sink) > 0 ? google_logging_project_sink.sink[0].writer_identity : null) : local.is_folder ? (length(google_logging_folder_sink.sink) > 0 ? google_logging_folder_sink.sink[0].writer_identity : null) : local.is_org ? (length(google_logging_organization_sink.sink) > 0 ? google_logging_organization_sink.sink[0].writer_identity : null) : (length(google_logging_billing_account_sink.sink) > 0 ? google_logging_billing_account_sink.sink[0].writer_identity : null)
  sink_id     = local.is_project ? (length(google_logging_project_sink.sink) > 0 ? google_logging_project_sink.sink[0].id : null) : local.is_folder ? (length(google_logging_folder_sink.sink) > 0 ? google_logging_folder_sink.sink[0].id : null) : local.is_org ? (length(google_logging_organization_sink.sink) > 0 ? google_logging_organization_sink.sink[0].id : null) : (length(google_logging_billing_account_sink.sink) > 0 ? google_logging_billing_account_sink.sink[0].id : null)
}

output "writer_identity" {
  description = "Writer identity (grant this principal access to the destination)"
  value       = local.sink_writer
}

output "sink_id" {
  description = "Sink resource ID"
  value       = local.sink_id
}
