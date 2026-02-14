/**
 * Standalone log export module: one log sink at project, folder, org, or billing level.
 * Only google_logging_*_sink—no module calls. Create destination (GCS, Pub/Sub, BQ) elsewhere and pass destination_uri.
 */

locals {
  is_project = var.parent_resource_type == "project"
  is_folder  = var.parent_resource_type == "folder"
  is_org     = var.parent_resource_type == "organization"
  is_billing = var.parent_resource_type == "billing_account"
  bq_opts    = var.bigquery_use_partitioned_tables != null ? [{ use_partitioned_tables = var.bigquery_use_partitioned_tables }] : []
}

resource "google_logging_project_sink" "sink" {
  count                  = local.is_project ? 1 : 0
  name                   = var.log_sink_name
  description            = var.description
  project                = var.parent_resource_id
  filter                 = var.filter
  destination            = var.destination_uri
  unique_writer_identity = var.unique_writer_identity
  disabled               = var.disabled

  dynamic "bigquery_options" {
    for_each = local.bq_opts
    content {
      use_partitioned_tables = bigquery_options.value.use_partitioned_tables
    }
  }

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = try(exclusions.value.description, null)
      filter      = exclusions.value.filter
      disabled    = try(exclusions.value.disabled, false)
    }
  }
}

resource "google_logging_folder_sink" "sink" {
  count              = local.is_folder ? 1 : 0
  name               = var.log_sink_name
  description        = var.description
  folder             = var.parent_resource_id
  filter             = var.filter
  destination        = var.destination_uri
  include_children   = var.include_children
  intercept_children = var.intercept_children
  unique_writer_identity = var.unique_writer_identity
  disabled           = var.disabled

  dynamic "bigquery_options" {
    for_each = local.bq_opts
    content {
      use_partitioned_tables = bigquery_options.value.use_partitioned_tables
    }
  }

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = try(exclusions.value.description, null)
      filter      = exclusions.value.filter
      disabled    = try(exclusions.value.disabled, false)
    }
  }
}

resource "google_logging_organization_sink" "sink" {
  count              = local.is_org ? 1 : 0
  name               = var.log_sink_name
  description        = var.description
  org_id             = var.parent_resource_id
  filter             = var.filter
  destination        = var.destination_uri
  include_children   = var.include_children
  intercept_children = var.intercept_children
  unique_writer_identity = var.unique_writer_identity
  disabled           = var.disabled

  dynamic "bigquery_options" {
    for_each = local.bq_opts
    content {
      use_partitioned_tables = bigquery_options.value.use_partitioned_tables
    }
  }

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = try(exclusions.value.description, null)
      filter      = exclusions.value.filter
      disabled    = try(exclusions.value.disabled, false)
    }
  }
}

resource "google_logging_billing_account_sink" "sink" {
  count           = local.is_billing ? 1 : 0
  name            = var.log_sink_name
  description     = var.description
  billing_account = var.parent_resource_id
  filter          = var.filter
  destination     = var.destination_uri
  unique_writer_identity = var.unique_writer_identity
  disabled        = var.disabled

  dynamic "bigquery_options" {
    for_each = local.bq_opts
    content {
      use_partitioned_tables = bigquery_options.value.use_partitioned_tables
    }
  }

  dynamic "exclusions" {
    for_each = var.exclusions
    content {
      name        = exclusions.value.name
      description = try(exclusions.value.description, null)
      filter      = exclusions.value.filter
      disabled    = try(exclusions.value.disabled, false)
    }
  }
}
