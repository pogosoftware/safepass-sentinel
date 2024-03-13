locals {
  name_prefix = var.name_prefix == null || var.name_prefix == "" ? "" : format("%s-", var.name_prefix)

  create_network_workspace = contains(["dev"], var.environment)
  network_workspace_name   = format("%snetwork-%s", local.name_prefix, var.environment)

  create_hcp_cloud_workspace = contains(["dev"], var.environment)
  hcp_cloud_workspace_name   = format("%shcp-cloud-%s", local.name_prefix, var.environment)

  create_vault_workspace = contains(["dev"], var.environment)
  vault_workspace_name   = format("%svault-%s", local.name_prefix, var.environment)

  create_boundary_workspace = contains(["dev"], var.environment)
  boundary_workspace_name   = format("%sboundary-%s", local.name_prefix, var.environment)

  create_tfc_agent_workspace = contains(["dev"], var.environment)
  tfc_agent_workspace_name   = format("%stfc-agent-%s", local.name_prefix, var.environment)
}
