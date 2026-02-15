output "server_id" {
  description = "PostgreSQL server ID"
  value       = azurerm_postgresql_flexible_server.this.id
}

output "fqdn" {
  description = "FQDN of the server"
  value       = azurerm_postgresql_flexible_server.this.fqdn
}

output "server_name" {
  description = "Server name"
  value       = azurerm_postgresql_flexible_server.this.name
}
