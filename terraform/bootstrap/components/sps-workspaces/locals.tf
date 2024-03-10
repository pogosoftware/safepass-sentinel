locals {
  tfe_project_name = var.tfe_project_name

  network_workspace_name   = format("sps-network-%s", var.environment)
  hcp_cloud_workspace_name = format("sps-hcp-cloud-%s", var.environment)
  vault_workspace_name     = format("sps-vault-%s", var.environment)
  boundary_workspace_name  = format("sps-boundary-%s", var.environment)
  vpn_workspace_name       = format("sps-vpn-%s", var.environment)
  tfc_agent_workspace_name = format("sps-tfc-agent-%s", var.environment)
}
