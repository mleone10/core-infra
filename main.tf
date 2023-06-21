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

resource "aws_route53_record" "root" {
  zone_id = aws_route53_zone.mleone_dev.zone_id
  name    = "mleone.dev"
  type    = "A"
  ttl     = 3600
  records = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
}

resource "aws_route53_record" "homelab_redirect" {
  zone_id = aws_route53_zone.mleone_dev.zone_id
  name    = "*.avenir.mleone.dev"
  type    = "CNAME"
  ttl     = 3600
  records = ["avenir.mleone.dev"]
}
