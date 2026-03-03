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
  type = string
}

variable "tags" {
  type = map(string)
}

variable "db_subnet_group_name" {
  type = string
}

variable "rds_sg_id" {
  type = string
}