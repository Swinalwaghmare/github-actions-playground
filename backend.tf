terraform {
  backend "s3" {
    bucket = "swinal-github-action-terraform"    
    key = "github/terraform.tfstate"
    region = "us-east-1"
  }
}
