locals {
  vault_public_endpoint_url = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_public_endpoint_url
  vault_cluster_token       = data.hcp_vault_secrets_secret.vault_cluster_admin_token.secret_value
}