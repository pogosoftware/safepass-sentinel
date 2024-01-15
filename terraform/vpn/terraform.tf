terraform {
  required_version = "1.6.6"

  required_providers {
    tls = {
      source  = "hashicorp/tls"
      version = "4.0.5"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.32.1"
    }
  }
}
