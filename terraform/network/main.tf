module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.6.0"

  name = var.network_vpc_name
  cidr = var.network_vpc_cidr

  azs             = var.network_vpc_azs
  private_subnets = var.network_vpc_private_subnets
  public_subnets  = var.network_vpc_public_subnets

  enable_nat_gateway     = var.network_enable_nat_gateway
  single_nat_gateway     = var.network_single_nat_gateway
  one_nat_gateway_per_az = var.network_one_nat_gateway_per_az

  enable_dns_hostnames = var.network_enable_dns_hostnames
  enable_dns_support   = var.network_enable_dns_support

  manage_default_vpc            = var.network_manage_default_vpc
  manage_default_security_group = var.network_manage_default_security_group
  manage_default_network_acl    = var.network_manage_default_network_acl
}

resource "aws_security_group" "this" {
  for_each = var.network_security_groups

  name        = each.key
  description = each.value.description
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = each.key
  }
}
