locals {
  boundary_cluster_url = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_url
  boundary_username    = data.hcp_vault_secrets_secret.boundary_username.secret_value
  boundary_password    = data.hcp_vault_secrets_secret.boundary_password.secret_value

  vault_public_endpoint_url = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_public_endpoint_url
  vault_client_token        = data.hcp_vault_secrets_secret.vault_boundary_client_token.secret_value
  vault_namespace           = data.terraform_remote_state.vault.outputs.vault_namespace
}