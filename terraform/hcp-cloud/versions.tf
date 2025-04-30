terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.81.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.100.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.60.1"
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
