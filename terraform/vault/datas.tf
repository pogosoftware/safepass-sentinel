data "hcp_organization" "this" {}

data "terraform_remote_state" "hcp_cloud" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = local.hcp_cloud_workspace_name
    }
  }
}
