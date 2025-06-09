# Configure the AWS Provider
# This tells Terraform to work with Amazon Web Services in the US East (N. Virginia) region.
provider "aws" {
  region = "us-east-1" # US East (N. Virginia) region
}

# Terraform Backend Configuration
# This S3 bucket stores your Terraform state file.
# It MUST be in the 'us-east-1' region and have a globally unique name.
terraform {
  backend "s3" {
    # IMPORTANT: Replace 'ahmed-terraform-state-20250609-us-east'
    # with the EXACT NAME of the S3 bucket you manually created in Step 1.3.
    bucket = "ahmed-terraform-state-20250609-us-east" # <<< REPLACE THIS!

    key     = "s3-bucket-project/terraform.tfstate" # Path/name of your state file within the S3 bucket.
    region  = "us-east-1"                           # MUST match the provider region above and your S3 bucket's region.
    encrypt = true                                  # Encrypt the state file (good practice).
  }
}

# Resource: Define an AWS S3 Bucket
# This block tells Terraform to CREATE a new S3 bucket for your project.
resource "aws_s3_bucket" "my_project_bucket" {
  # This is the actual name of the S3 bucket that will be created in AWS.
  # IMPORTANT: This name also MUST be GLOBALLY UNIQUE across ALL of AWS.
  # Use a different unique name than your state bucket.
  bucket = "ahmed-project-data-bucket-20250609-us-east" # <<< REPLACE THIS with another UNIQUE name!

  # ACL (Access Control List): 'private' means only the bucket owner can access it.
  acl    = "private"

  # Tags: Simple labels for your AWS resource.
  tags = {
    Environment = "Dev"
    Project     = "SimpleS3UsEastDemo"
    ManagedBy   = "Jenkins"
  }
}

# Output: Display the name of the created bucket after deployment
output "project_bucket_name" {
  description = "The name of the S3 bucket created for the project."
  value       = aws_s3_bucket.my_project_bucket.bucket
}
