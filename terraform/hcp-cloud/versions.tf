terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.78.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.100.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.61.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "4.5.0"
    }
  }
}
