terraform {
  required_version = "~> 1.7"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.72.1"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.83"
    }
  }
}
