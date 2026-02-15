output "lb_id" {
  description = "Load balancer ID"
  value       = azurerm_lb.this.id
}

output "backend_pool_id" {
  description = "Backend address pool ID (for NIC attachment)"
  value       = azurerm_lb_backend_address_pool.this.id
}

output "frontend_private_ip" {
  description = "Frontend private IP (when internal)"
  value       = azurerm_lb.this.private_ip_address
}
