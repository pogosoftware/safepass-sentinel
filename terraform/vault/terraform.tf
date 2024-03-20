terraform {
  required_version = "~> 1.7.0"

  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.83"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.0"
    }
    utils = {
      source  = "cloudposse/utils"
      version = "~> 1.18"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}
