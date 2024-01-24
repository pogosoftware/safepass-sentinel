terraform {
  required_version = "1.6.6"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.79.0"
    }
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.1.12"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.24.0"
    }
  }
}
