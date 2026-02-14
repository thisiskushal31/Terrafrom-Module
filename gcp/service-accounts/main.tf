/**
 * Standalone module: service accounts, optional project roles and keys.
 * Only google_service_account, google_project_iam_member, google_service_account_key—no module calls.
 */

locals {
  prefix = var.prefix != "" ? "${var.prefix}-" : ""
}

resource "google_service_account" "accounts" {
  for_each = toset(var.names)

  project      = var.project_id
  account_id   = "${local.prefix}${each.value}"
  display_name = var.display_name != "" ? var.display_name : "Terraform-managed service account"
  description  = var.description
}

# project_roles: list of "project_id=>roles/role" (empty project_id = current project)
locals {
  pr_parsed = [
    for pr in var.project_roles : {
      project = trimspace(split("=>", pr)[0])
      role    = trimspace(split("=>", pr)[1])
    } if length(split("=>", pr)) == 2
  ]
  sa_role_bindings = flatten([
    for name in var.names : [
      for pr in local.pr_parsed : {
        key     = "${name}-${pr.project != "" ? pr.project : var.project_id}-${pr.role}"
        sa_name = name
        project = pr.project != "" ? pr.project : var.project_id
        role    = pr.role
      }
    ]
  ])
  sa_role_map = { for b in local.sa_role_bindings : b.key => b }
}

resource "google_project_iam_member" "project_roles" {
  for_each = local.sa_role_map

  project = each.value.project
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.accounts[each.value.sa_name].email}"
}

resource "google_service_account_key" "keys" {
  for_each = var.generate_keys ? toset(var.names) : toset([])

  service_account_id = google_service_account.accounts[each.value].name
}
