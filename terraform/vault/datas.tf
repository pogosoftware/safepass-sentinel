data "hcp_organization" "this" {}

data "terraform_remote_state" "hcp_cloud" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = var.hcp_cloud_workspace_name
    }
  }
}

data "hcp_vault_secrets_secret" "vault_cluster_admin_token" {
  app_name    = data.terraform_remote_state.hcp_cloud.outputs.hcp_cloud_secret_app_name
  secret_name = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_cluster_admin_token_secret_name
}
