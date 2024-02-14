locals {
  # hcp
  hcp_cloud_workspace_name = format("%s-%s", var.hcp_cloud_workspace_name, var.environment)

  # boundary
  boundary_username = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_username
  boundary_password = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_password

  # vault
  vault_public_endpoint_url      = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_public_endpoint_url
  vault_devops_namespace_path_fq = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_devops_namespace_path_fq
}
