resource "aws_db_subnet_group" "this" {
  name       = "${var.identifier}-subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {
  identifier         = var.identifier
  engine             = var.engine
  engine_version     = var.engine_version
  instance_class     = var.instance_class
  allocated_storage  = var.allocated_storage
  db_name            = var.db_name
  username           = var.username
  password           = var.password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = false
  skip_final_snapshot    = var.skip_final_snapshot
  tags                   = var.tags
}
