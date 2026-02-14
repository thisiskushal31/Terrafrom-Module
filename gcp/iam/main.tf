/**
 * Standalone module: project-level IAM bindings (additive).
 * Only google_project_iam_member—no module calls.
 */

locals {
  iam_flat = flatten([
    for project in var.projects : [
      for role, members in var.bindings : [
        for member in members : { project = project, role = role, member = member }
      ]
    ]
  ])
  iam_map = { for i, b in local.iam_flat : "${b.project}-${b.role}-${replace(b.member, ":", "-")}-${i}" => b }
}

resource "google_project_iam_member" "bindings" {
  for_each = local.iam_map

  project = each.value.project
  role    = each.value.role
  member  = each.value.member
}
