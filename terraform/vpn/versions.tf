terraform {
  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.6"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.78.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "0.101.0"
    }
  }
}
