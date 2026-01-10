terraform {
  backend "s3" {
    bucket = "enumavictoriaS3-2026TS"
    key    = "enumavictoria/prodution/terraform.tfstate"
    region = "us-east-1"
  }
}