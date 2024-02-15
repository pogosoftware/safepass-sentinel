locals {
  # hcp
  hcp_cloud_workspace_name = format("%s-%s", var.hcp_cloud_workspace_name, var.environment)
  hcp_vault_workspace_name = format("%s-%s", var.hcp_vault_workspace_name, var.environment)

  # boundary
  boundary_cluster_url = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_url
  boundary_username    = data.vault_kv_secret_v2.boundary.data["username"]
  boundary_password    = data.vault_kv_secret_v2.boundary.data["password"]

  boundary_vault_mount_name  = data.terraform_remote_state.hcp_vault.outputs.vault_apps_mount_name
  boundary_vault_secret_name = data.terraform_remote_state.hcp_vault.outputs.vault_apps_boundary_secret_name

  vault_private_endpoint_url = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_private_endpoint_url
  vault_client_token         = data.vault_kv_secret_v2.boundary.data["vault_token"]
  vault_namespace            = "admin/dev/devops"
}