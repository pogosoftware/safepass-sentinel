terraform {
  required_version = "~> 1.7"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.83"
    }
  }
}
