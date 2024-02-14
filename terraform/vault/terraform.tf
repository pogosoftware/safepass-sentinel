terraform {
  required_version = "~> 1.7.0"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.79.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "3.24.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = "1.15.0"
    }
  }
}
