resource "azurerm_lb" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  sku_tier            = var.sku_tier
  frontend_ip_configuration {
    name                          = "frontend"
    public_ip_address_id          = var.public_ip_address_id
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = var.subnet_id != null ? "Static" : null
    private_ip_address            = var.private_ip_address
  }
  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  name            = "backend-pool"
  loadbalancer_id = azurerm_lb.this.id
}

resource "azurerm_lb_probe" "this" {
  count = var.probe_port != null ? 1 : 0

  name            = "probe"
  loadbalancer_id = azurerm_lb.this.id
  port            = var.probe_port
  protocol        = var.probe_protocol
}

resource "azurerm_lb_rule" "this" {
  for_each = var.lb_rules

  name                           = each.key
  loadbalancer_id                = azurerm_lb.this.id
  frontend_ip_configuration_name = "frontend"
  protocol                       = each.value.protocol
  frontend_port                  = each.value.frontend_port
  backend_port                  = each.value.backend_port
  backend_address_pool_ids      = [azurerm_lb_backend_address_pool.this.id]
  probe_id                      = var.probe_port != null ? azurerm_lb_probe.this[0].id : null
}
