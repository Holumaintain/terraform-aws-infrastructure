terraform {
  backend "s3" {
    bucket       = "terraform-demo-clement-state-20260810"
    key          = "terraform-demo/terraform.tfstate"
    region       = "eu-west-1"
    encrypt      = true
    use_lockfile = true
  }
}