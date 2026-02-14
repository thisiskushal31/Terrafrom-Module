output "folders" {
  description = "Folder resources by name"
  value       = google_folder.folders
}

output "ids" {
  description = "Folder IDs (resource names) by name"
  value       = { for k, v in google_folder.folders : k => v.name }
}

output "names" {
  description = "Folder display names by name"
  value       = { for k, v in google_folder.folders : k => v.display_name }
}
