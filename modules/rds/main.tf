resource "aws_db_instance" "rds_instance" {
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.version_engine
  instance_class         = var.instance_class
  identifier             = var.identifier
  username               = var.username
  password               = var.password
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot    = true
  tags                   = var.tags
}