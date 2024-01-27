terraform {
  required_version = "~> 1.7.0"

  required_providers {
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
