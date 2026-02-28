# VPC
variable "main_vpc_cidr_block" {
  type = string
}

variable "vpc_tags" {
  type = map(string)
}

# Public Subnet
variable "public_subnet_cidr_block" {
  type = string
}

variable "public_subnet_availability_zone" {
  type = string
}

variable "public_name_tag" {
  type = map(string)
}

# Private Subnet
variable "private_subnet_cidr_block" {
  type = string
}

variable "private_subnet_availability_zone" {
  type = string
}

variable "private_name_tag" {
  type = map(string)
}

# Internet Gateway
variable "internet_gateway_tag" {
  type = map(string)
}

# Route Table
variable "public_route_table_cidr" {
  type = string
}

variable "public_route_table_name" {
  type = map(string)
}

# Security Group
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# Security Group RDS
variable "ingress_rds" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

# EC2
variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_tags" {
  type = map(string)
}


#RDS
variable "rds_subnet_group" {
  type = string
}

variable "rds_tags" {
  type = map(string)
}

variable "allocated_storage" {
  type = number
}

variable "engine" {
  type = string
}

variable "version_engine" {
  type = string
}

variable "instance_class" {
  type = string  
}

variable "identifier" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {
  type =  string 
  sensitive = true
}