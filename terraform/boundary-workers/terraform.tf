terraform {
  required_version = "~> 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.79.0"
    }
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.1.12"
    }
  }
}
