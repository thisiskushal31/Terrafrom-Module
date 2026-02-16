output "subscription_id" {
  description = "Redis Cloud subscription ID"
  value       = rediscloud_subscription.this.id
}

output "database_id" {
  description = "Redis Cloud database ID"
  value       = rediscloud_subscription_database.this.db_id
}

output "public_endpoint" {
  description = "Public endpoint to connect to the database"
  value       = rediscloud_subscription_database.this.public_endpoint
}

output "private_endpoint" {
  description = "Private endpoint to connect to the database"
  value       = rediscloud_subscription_database.this.private_endpoint
}
