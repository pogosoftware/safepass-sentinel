data "hcp_organization" "this" {}

data "hcp_project" "this" {
  project = var.hcp_project_id
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = var.hcp_network_workspace_name
    }
  }
}