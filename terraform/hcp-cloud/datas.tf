data "hcp_organization" "this" {}

data "tfe_workspace_ids" "workspaces" {
  names        = var.hcp_vault_variable_set_workspaces
  organization = data.hcp_organization.this.name
}

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
