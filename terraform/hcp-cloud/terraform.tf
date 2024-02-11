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
    vault = {
      source  = "hashicorp/vault"
      version = "3.24.0"
    }
  }
}
