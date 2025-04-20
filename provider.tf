terraform {
  required_version = ">= 1.2.6"

  backend "local" {
    path = "./terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.40, < 5.50"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}
