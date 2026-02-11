provider "aws" {
  region = var.region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "scales-tfstate-bucket"
    key    = "path/terraform.tfstate"
    region = "sa-east-1"
  }
}