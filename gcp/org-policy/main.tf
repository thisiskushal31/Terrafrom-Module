/**
 * Standalone Org Policy: one policy (boolean or list) at project, folder, or organization.
 * Only google_* — no module calls.
 */

locals {
  parent_path = var.parent_type == "organization" ? "organizations/${var.parent_id}" : (var.parent_type == "folder" ? "folders/${var.parent_id}" : "projects/${var.parent_id}")
  policy_name = "${local.parent_path}/policies/${var.constraint}"
}

resource "google_org_policy_policy" "policy" {
  name   = local.policy_name
  parent = local.parent_path

  spec {
    dynamic "rules" {
      for_each = var.policy_type == "boolean" ? [1] : []
      content {
        enforce = var.enforce ? "TRUE" : "FALSE"
      }
    }
    dynamic "rules" {
      for_each = var.policy_type == "list" ? [1] : []
      content {
        allow_all = var.list_allow_all == true ? "TRUE" : null
        deny_all  = var.list_deny_all == true ? "TRUE" : null
        dynamic "values" {
          for_each = var.list_allow_all != true && var.list_deny_all != true && (length(coalesce(var.allow_values, [])) > 0 || length(coalesce(var.deny_values, [])) > 0) ? [1] : []
          content {
            allowed_values = length(coalesce(var.allow_values, [])) > 0 ? var.allow_values : null
            denied_values  = length(coalesce(var.deny_values, [])) > 0 ? var.deny_values : null
          }
        }
      }
    }
  }
}
