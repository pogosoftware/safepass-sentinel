locals {
  vault_private_endpoint_url = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_private_endpoint_url

  # boundary
  boundary_username = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_username
  boundary_password = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_password
}
