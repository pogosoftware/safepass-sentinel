locals {
  bootstrap_workspace_name = format("sps-bootstrap-%s", var.environment)

  vault_jwt_roles = {
    vault = data.terraform_remote_state.bootstrap.outputs.vault_workspace_name
  }
  vault_cluster_id    = format("%s-%s", var.vault_cluster_id, var.environment)
  boundary_cluster_id = format("%s-%s", var.boundary_cluster_id, var.environment)

  # boundary
  boundary_username = random_string.boundary_username.result
  boundary_password = random_password.boundary_password.result

  # aws peering
  peer_vpc_id           = data.terraform_remote_state.network.outputs.vpc_id
  peer_account_id       = data.terraform_remote_state.network.outputs.vpc_owner_id
  peer_vpc_region       = var.aws_region
  peer_destination_cidr = data.terraform_remote_state.network.outputs.vpc_cidr_block
  peering_id            = format("%s-peering-%s", var.peering_id, var.environment)
  route_id              = format("%s-hvn-%s", var.route_id, var.environment)
}
