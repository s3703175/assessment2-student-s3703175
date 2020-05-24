provider "aws" {
  version = "~> 2.8"
  region  = "us-east-1"
}

resource "aws_key_pair" "aws_key_pair" {
  key_name   = "aws-key-pair"
  public_key = var.key_pair
}

terraform {
  backend "s3" {
    bucket         = "aws-bucket-for-assignment"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-up-and-running-locks"
  }
}