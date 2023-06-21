# Common infrastructure configuration
terraform {
  backend "s3" {
    bucket = "leone-terraform-states"
    key    = "core-infra.tfstate"
    region = "us-east-1"
  }
}

# AWS Provider configuration
provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "mleone_dev" {
  name = "mleone.dev"
}
