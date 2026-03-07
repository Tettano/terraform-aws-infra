##############################
# 1️⃣ VPC
##############################
resource "aws_vpc" "main" {
  cidr_block = var.main_vpc_cidr_block

  tags = var.vpc_tags
}

##############################
# 2️⃣ Public Subnet
##############################
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_block
  availability_zone       = var.public_subnet_availability_zone
  map_public_ip_on_launch = true

  tags = var.public_name_tag
}

##############################
# 3️⃣ Private Subnet
##############################
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.private_subnet_availability_zone

  tags = var.private_name_tag

}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr_block_2
  availability_zone = var.private_subnet_availability_zone_2

  tags = var.private_name_tag_2
}

##############################
# 4️⃣ Internet Gateway
##############################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = var.internet_gateway_tag
}

##############################
# 5️⃣ Public Route Table
##############################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.public_route_table_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = var.public_route_table_name
}

##############################
# 6️⃣ Route Table Association
##############################
resource "aws_route_table_association" "public_associate" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

##############################
# 7️⃣ Security Group (Dynamic ingress)
##############################
resource "aws_security_group" "main_sg" {
  name        = "main-security-group"
  description = "Security group with dynamic ingress rules"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-security-group"
  }
}

#  Security Group RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "security-group-rds"
  vpc_id      = aws_vpc.main.id


  dynamic "ingress" {
    for_each = var.ingress_rds
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security-group-rds"
  }
}

# RDS Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds_subnet_group
  subnet_ids = [aws_subnet.private.id, aws_subnet.private_2.id]
  tags       = var.rds_tags
}

