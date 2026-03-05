terraform {
  backend "s3" {
    bucket         = "terraform-state-tettano" # your S3 bucket name
    key            = "terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}