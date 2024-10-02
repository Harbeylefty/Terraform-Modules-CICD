terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}

// Create s3 bucket to store state file
resource "aws_s3_bucket" "mybucket" {
  bucket = "myterraformstatefilebucket2024"
}

// Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.mybucket.id 
  versioning_configuration {
    status = "Enabled"
  }
}

// Enable encryption so that the state file is encrypted
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.mybucket.id 

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm  = "AES256" 
    }
  }
}

// restrict public access to bucket 
resource "aws_s3_bucket_public_access_block" "acl" {
  bucket = aws_s3_bucket.mybucket.id

  block_public_acls = false
  block_public_policy = false 
}

// create dynamodb table  to enable state locking
resource "aws_dynamodb_table" "statelock" {
  name = "state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}