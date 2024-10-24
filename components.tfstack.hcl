component "network" {
  source = "./terraform/network"

  inputs = {
    aws_region = var.aws_region
  }
  
  providers = {
    aws = provider.aws.develop
  }
}
