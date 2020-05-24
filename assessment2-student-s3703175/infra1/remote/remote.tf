provider "aws" {
  version = "~> 2.8"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "aws-bucket-for-assignment"
  acl    = "private"
  force_destroy = true

  tags = {
    Name        = "aws_bucket_assignment_two"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}