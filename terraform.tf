terraform {
  #   backend "s3" {
  #     bucket         = "myorg-terraform-states"
  #     key            = "myapp/production/tfstate"
  #     region         = "us-east-1"
  #     dynamodb_table = "TableName"
  #   }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region                   = var.region
  shared_credentials_files = var.shared_credentials_files
  profile                  = var.profile
}