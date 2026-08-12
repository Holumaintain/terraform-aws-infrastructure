terraform {
  backend "s3" {
    bucket       = "terraform-demo-clement-20260806"
    key          = "terraform-demo/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}