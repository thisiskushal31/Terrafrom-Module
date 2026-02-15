resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id
  revoke_rules_on_delete = var.revoke_rules_on_delete
  tags        = merge(var.tags, { "Name" = var.name })
}

resource "aws_security_group_rule" "ingress" {
  for_each = { for i, r in var.ingress_rules : i => r }

  security_group_id = aws_security_group.this.id
  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = lookup(each.value, "cidr_blocks", [])
  description       = lookup(each.value, "description", null)
  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}

resource "aws_security_group_rule" "egress" {
  for_each = { for i, r in var.egress_rules : i => r }

  security_group_id = aws_security_group.this.id
  type              = "egress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = lookup(each.value, "cidr_blocks", ["0.0.0.0/0"])
  description       = lookup(each.value, "description", null)
}
