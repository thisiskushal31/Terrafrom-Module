/**
 * Standalone module: Cloud Resource Manager folders + optional IAM.
 * Only google_folder and google_folder_iam_binding—no module calls.
 * GCP product: Cloud Resource Manager → Folders.
 */

locals {
  prefix = var.prefix != "" ? "${var.prefix}-" : ""
}

resource "google_folder" "folders" {
  for_each = toset(var.names)

  display_name        = "${local.prefix}${each.value}"
  parent              = var.parent
  deletion_protection = var.deletion_protection
}

locals {
  per_bindings = var.set_roles ? flatten([
    for fname, cfg in var.per_folder_admins : [
      for role in coalesce(cfg.roles, var.folder_admin_roles) : {
        folder  = fname
        role    = role
        members = cfg.members
      }
    ]
  ]) : []
  all_bindings = var.set_roles && length(var.all_folder_admins) > 0 ? flatten([
    for fname in var.names : [
      for role in var.folder_admin_roles : {
        folder  = fname
        role    = role
        members = var.all_folder_admins
      }
    ]
  ]) : []
  per_map  = { for b in local.per_bindings : "${b.folder}-${b.role}" => b }
  all_map  = { for b in local.all_bindings : "${b.folder}-${b.role}" => b }
  all_only = { for k, v in local.all_map : k => v if !contains(keys(local.per_map), k) }
  merged   = merge(
    { for k, v in local.per_map : k => { folder = v.folder, role = v.role, members = distinct(concat(v.members, try(local.all_map[k].members, []))) } },
    { for k, v in local.all_only : k => { folder = v.folder, role = v.role, members = v.members } }
  )
}

resource "google_folder_iam_binding" "bindings" {
  for_each = local.merged

  folder  = google_folder.folders[each.value.folder].name
  role    = each.value.role
  members = each.value.members
}
