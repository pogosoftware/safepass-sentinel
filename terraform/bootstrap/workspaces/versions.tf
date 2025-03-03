terraform {
  required_version = ">= 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.100.0"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.60.1"
    }
  }
}
