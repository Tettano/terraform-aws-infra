terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0"
    }
  }
}

# Configure the aws
provider "aws" {
  region = "ap-southeast-1"
}