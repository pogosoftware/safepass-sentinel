terraform {
  required_version = "~> 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.83"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.25"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.52"
    }
  }
}
