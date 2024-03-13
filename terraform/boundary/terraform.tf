terraform {
  required_version = "~> 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
    boundary = {
      source  = "hashicorp/boundary"
      version = "~> 1.1"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.83"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.25"
    }
  }
}
