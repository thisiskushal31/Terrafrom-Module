output "id" {
  description = "Azure Cache for Redis resource ID"
  value       = azurerm_redis_cache.this.id
}

output "hostname" {
  description = "Redis hostname"
  value       = azurerm_redis_cache.this.hostname
}

output "port" {
  description = "Redis port"
  value       = azurerm_redis_cache.this.port
}

output "ssl_port" {
  description = "Redis SSL port"
  value       = azurerm_redis_cache.this.ssl_port
}

output "primary_access_key" {
  description = "Primary access key"
  value       = azurerm_redis_cache.this.primary_access_key
  sensitive   = true
}

output "secondary_access_key" {
  description = "Secondary access key"
  value       = azurerm_redis_cache.this.secondary_access_key
  sensitive   = true
}
