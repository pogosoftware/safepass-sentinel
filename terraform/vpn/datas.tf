data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = var.hcp_orgranization_id
    workspaces = {
      name = var.hcp_network_workspace_name
    }
  }
}
