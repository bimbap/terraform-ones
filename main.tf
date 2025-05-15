#initialitation providers

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
  access_key = "your access key aws"
  secret_key = "you access secret key aws"
  token = "your session token aws"
}