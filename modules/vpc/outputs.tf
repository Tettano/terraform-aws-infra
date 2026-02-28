# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Public Subnet ID
output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

# Private Subnet ID
output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

# Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

# Public Route Table ID
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}


output "main_sg_id" {
  description = "Security group ID"
  value       = aws_security_group.main_sg.id
}

output "rds_subnet_group_name" {
  description = "The name of the RDS subnet group"
  value       = aws_db_subnet_group.rds_subnet_group.name
}


