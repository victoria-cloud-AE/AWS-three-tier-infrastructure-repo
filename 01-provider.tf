# provider "aws" {
#   region = "us-east-1"
# }


terraform {
  required_providers {
    namecheap = {
      source  = "namecheap/namecheap"
      version = "2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}
