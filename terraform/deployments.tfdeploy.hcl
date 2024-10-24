identity_token "aws" {
  audience = [ "aws.workload.identity" ]
}

deployment "deployment" {
  inputs = {
    aws_region = "eu-central-1"
  }
}