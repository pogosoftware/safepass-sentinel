data "hcp_organization" "this" {}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = var.hcp_network_workspace_name
    }
  }
}
