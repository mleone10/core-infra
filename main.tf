# Common infrastructure configuration
terraform {
  backend "s3" {
    bucket       = "leone-terraform-states"
    key          = "core-infra.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

# AWS Provider configuration
provider "aws" {
  region = "us-east-1"
}

resource "aws_route53_zone" "mleone_dev" {
  name = "mleone.dev"
}

data "aws_route53_zone" "lab" {
  name = "lab.mleone.dev"
}

resource "aws_route53_record" "lab_ns" {
  zone_id = aws_route53_zone.mleone_dev.zone_id
  name    = "lab.mleone.dev"
  type    = "NS"
  ttl     = 3600
  records = data.aws_route53_zone.lab.name_servers
}

resource "aws_route53_record" "bluesky_domain" {
  zone_id = aws_route53_zone.mleone_dev.zone_id
  name    = "_atproto"
  type    = "TXT"
  ttl     = 3600
  records = ["did=did:plc:vrmm3txjmqcit4uyyrluihcq"]
}

output "mleone_dev_zone_id" {
  description = "Zone ID for mleone.dev hosted zone"
  value       = aws_route53_zone.mleone_dev.id
}
