provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = "private"
}

variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "my-unique-bucket-name-12345"
}
