terraform {
  required_version = "~> 1.7.0"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.79"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.31"
    }
  }
}
