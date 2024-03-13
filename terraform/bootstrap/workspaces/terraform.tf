terraform {
  required_version = "~>1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.39"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.83"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.52"
    }

  }

  cloud {
    organization = "pogosoftware"

    workspaces {
      name = "sps-bootstrap-dev"
    }
  }
}
