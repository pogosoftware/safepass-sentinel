locals {
  bootstrap_workspace_name = format("sps-bootstrap-%s", var.environment)

  # boundary
  boundary_username = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_username
  boundary_password = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_password
}
