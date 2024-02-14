locals {
  hcp_network_workspace_name = format("%s-%s", var.hcp_network_workspace_name, var.environment)
  hcp_vault_variable_set_workspaces = { for workspace in var.hcp_vault_variable_set_workspaces :
    workspace => format("%s-%s", workspace, var.environment)
  }
  hcp_cloud_vault_cluster_id    = format("%s-%s", var.hcp_cloud_vault_cluster_id, var.environment)
  hcp_cloud_boundary_cluster_id = format("%s-%s", var.hcp_cloud_boundary_cluster_id, var.environment)

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
