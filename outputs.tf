output "vpc_id" {
  description = "The ID of the main VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = module.vpc.private_subnet_id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "public_route_table" {
  description = "Public Route Table"
  value       = module.vpc.public_route_table_id
}

output "rds_subnet_group_name" {
  description = "The RDS subnet group name"
  value       = module.vpc.rds_subnet_group_name
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}