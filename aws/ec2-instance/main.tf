resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address
  key_name                    = var.key_name
  vpc_security_group_ids      = length(var.vpc_security_group_ids) > 0 ? var.vpc_security_group_ids : null

  tags = merge(var.tags, { "Name" = var.name })
}
