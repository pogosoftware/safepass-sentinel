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
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.25.0"
    }
  }
}
