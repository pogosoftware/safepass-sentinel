data "hcp_organization" "this" {}

data "terraform_remote_state" "bootstrap" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = local.bootstrap_workspace_name
    }
  }
}

data "terraform_remote_state" "hcp_cloud" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = data.terraform_remote_state.bootstrap.outputs.hcp_cloud_workspace_name
    }
  }
}
