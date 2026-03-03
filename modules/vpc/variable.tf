# VPC
variable "main_vpc_cidr_block" {
  description = "CIDR block for the main VPC"
  type        = string
}

variable "vpc_tags" {
  description = "Tags for the VPC"
  type        = map(string)
}

# Public Subnet
variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
}

variable "public_name_tag" {
  description = "Name tag for the public subnet"
  type        = map(string)
}

# Private Subnet
variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "private_subnet_availability_zone" {
  description = "Availability zone for the private subnet"
  type        = string
}

variable "private_name_tag" {
  description = "Name tag for the private subnet"
  type        = map(string)
}

# Internet Gateway
variable "internet_gateway_tag" {
  description = "Tag name for the Internet Gateway"
  type        = map(string)
}

# Route Table
variable "public_route_table_cidr" {
  description = "CIDR block for the route table route"
  type        = string
}

variable "public_route_table_name" {
  description = "Name tag for the route table"
  type        = map(string)
}

# Security Group ingress rules
variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# Security Group ingress RDS
variable "ingress_rds" {
  description = "List of ingress ruiles for the security group rds"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}


variable "rds_tags" {
  type = map(string)
}

variable "rds_subnet_group" {
  type = string
}