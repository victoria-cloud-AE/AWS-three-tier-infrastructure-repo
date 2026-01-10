terraform {
  backend "s3" {
    bucket = "enumavictorias3-2026ts"
    key    = "enumavictoria/prodution/terraform.tfstate"
    region = "us-east-1"
  }
}