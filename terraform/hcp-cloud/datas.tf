data "hcp_organization" "this" {}

data "tfe_workspace_ids" "workspaces" {
  names        = values(local.vault_variable_set_workspaces)
  organization = data.hcp_organization.this.name
}

data "hcp_project" "this" {
  project = var.hcp_project_id
}

data "terraform_remote_state" "bootstrap" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = local.bootstrap_workspace_name
    }
  }
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = data.terraform_remote_state.bootstrap.outputs.network_workspace_name
    }
  }
}
