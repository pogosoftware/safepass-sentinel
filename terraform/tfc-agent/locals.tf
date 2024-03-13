locals {
  ecs_cluster_private_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]
  ecs_cluster_sg_id             = data.terraform_remote_state.network.outputs.security_group_ids["tfc-agent"]

  ecs_cluster_role_name    = format("safepass_sentinel_ecs_%s", var.environment)
  ecs_task_role_name       = format("tfc_agent_ecs_%s", var.environment)
  ecs_cluster_name         = format("safepass_sentinel_%s", var.environment)
  ecs_service_name         = format("tfc_agent_%s", var.environment)
  ecs_task_definition_name = format("tfc_agent_%s", var.environment)

  tfc_agent_pool_name = format("Safepass_Sentinel_%s", var.environment)
  tfc_agent_name      = format("Safepass_Sentinel_%s", var.environment)

  execution_mode_agent_workspaces = {
    hcp_cloud = data.terraform_remote_state.bootstrap.outputs.workspaces["hcp_cloud"].id
    vault     = data.terraform_remote_state.bootstrap.outputs.workspaces["vault"].id
    boundary  = data.terraform_remote_state.bootstrap.outputs.workspaces["boundary"].id
  }
}
