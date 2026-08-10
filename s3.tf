############################################
# S3 Bucket
############################################

resource "aws_s3_bucket" "app_bucket" {
  bucket = "terraform-demo-clement-20260810-148598146690"

  tags = {
    Name        = "Terraform-S3-Bucket"
    Environment = "Development"
  }
}