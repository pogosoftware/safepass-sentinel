identity_token "aws" {
  audience = [ "aws.workload.identity" ]
}

deployment "deployment" {
  inputs = {
    aws_region = "eu-central-1"
    role_arn = "arn:aws:iam::974531304541:role/tfstacks-network"
    identity_token = identity_token.aws.jwt
  }
}