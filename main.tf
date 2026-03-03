module "vpc" {
  source = "./modules/vpc"

  main_vpc_cidr_block              = var.main_vpc_cidr_block
  vpc_tags                         = var.vpc_tags
  public_subnet_cidr_block         = var.public_subnet_cidr_block
  public_subnet_availability_zone  = var.public_subnet_availability_zone
  public_name_tag                  = var.public_name_tag
  private_subnet_cidr_block        = var.private_subnet_cidr_block
  private_subnet_availability_zone = var.private_subnet_availability_zone
  private_name_tag                 = var.private_name_tag
  internet_gateway_tag             = var.internet_gateway_tag
  public_route_table_cidr          = var.public_route_table_cidr
  public_route_table_name          = var.public_route_table_name
  ingress_rules                    = var.ingress_rules
  ingress_rds                      = var.ingress_rds
  rds_subnet_group                 = var.rds_subnet_group
  rds_tags                         = var.rds_tags
}

module "ec2" {
  source = "./modules/ec2"

  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnet_id
  sg_id         = module.vpc.main_sg_id
  instance_tags = var.instance_tags
}

module "rds" {
  source = "./modules/rds"

  allocated_storage    = var.allocated_storage
  engine               = var.engine
  version_engine       = var.version_engine
  instance_class       = var.instance_class
  identifier           = var.identifier
  username             = var.username
  db_subnet_group_name = module.vpc.rds_subnet_group_name
  rds_sg_id            = module.vpc.rds_sg_id
  password             = var.password
  tags                 = var.rds_tags

}
