terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.78.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.101.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.60.1"
    }
  }
}
