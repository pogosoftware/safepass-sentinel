locals {
  # boundary
  boundary_username = random_string.boundary_username.result
  boundary_password = random_password.boundary_password.result

  # aws peering
  peer_vpc_id           = data.terraform_remote_state.network.outputs.vpc_id
  peer_account_id       = data.terraform_remote_state.network.outputs.vpc_owner_id
  peer_vpc_region       = var.aws_region
  peer_destination_cidr = data.terraform_remote_state.network.outputs.vpc_cidr_block
}
