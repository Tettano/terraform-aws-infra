# VPC
variable "main_vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_tags" {
  type    = map(string)
  default = { Name = "main-vpc" }
}

# Public Subnet
variable "public_subnet_cidr_block" {
  type    = string
  default = "10.0.1.0/24"
}

variable "public_subnet_availability_zone" {
  type    = string
  default = "ap-southeast-1a"
}

variable "public_name_tag" {
  type    = map(string)
  default = { Name = "public-subnet" }
}

# Private Subnet
variable "private_subnet_cidr_block" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_availability_zone" {
  type    = string
  default = "ap-southeast-1b"
}

variable "private_name_tag" {
  type    = map(string)
  default = { Name = "private-subnet" }
}

# Internet Gateway
variable "internet_gateway_tag" {
  type    = map(string)
  default = { Name = "main-igw" }
}

# Route Table
variable "public_route_table_cidr" {
  type    = string
  default = "0.0.0.0/0"
}

variable "public_route_table_name" {
  type    = map(string)
  default = { Name = "public-route-table" }
}

# Security Group
variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}

# Security Group RDS
variable "ingress_rds" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]
    }
  ]
}

# EC2
variable "ami" {
  type    = string
  default = "ami-0c1c30571d2dae5c3"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "instance_tags" {
  type = map(string)
  default = {
    Name = "web-server"
  }
}

# RDS Subnet Group
variable "rds_subnet_group" {
  type    = string
  default = "rds-subnet-group"
}

variable "rds_tags" {
  type = map(string)
  default = {
    Name = "rds"
    Env  = "dev"
  }
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "engine" {
  type    = string
  default = "mysql"
}

variable "version_engine" {
  type    = string
  default = "8.0"
}

variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "identifier" {
  type    = string
  default = "my-rds-instance"
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}