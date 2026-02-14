output "projects" {
  description = "Projects that received bindings"
  value       = distinct([for b in google_project_iam_member.bindings : b.project])
}

output "members" {
  description = "Members that were bound"
  value       = distinct([for b in google_project_iam_member.bindings : b.member])
}
