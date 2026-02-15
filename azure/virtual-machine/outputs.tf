output "vm_id" {
  description = "VM resource ID"
  value       = var.os_type == "linux" ? azurerm_linux_virtual_machine.this[0].id : azurerm_windows_virtual_machine.this[0].id
}

output "private_ip_address" {
  description = "Private IP of the NIC"
  value       = azurerm_network_interface.this.private_ip_address
}

output "network_interface_id" {
  description = "NIC ID"
  value       = azurerm_network_interface.this.id
}
