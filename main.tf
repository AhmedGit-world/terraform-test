provider "aws" {
  region     = "us-east-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "my-jenkins-terraform-s3-bucket-12345"
  tags = {
    Name = "JenkinsTerraformBucket"
  }
}
