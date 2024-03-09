locals {
  ecs_cluster_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]
  # ecs_cluster_public_subnet_id = data.terraform_remote_state.hcp_network.outputs.public_subnet_ids[0]
  ecs_cluster_sg_id = data.terraform_remote_state.network.outputs.security_group_ids["tfc-agent"]

  ecs_cluster_role_name    = format("safepass_sentinel_ecs_%s", var.environment)
  ecs_task_role_name       = format("tfc_agent_ecs_%s", var.environment)
  ecs_cluster_name         = format("safepass_sentinel_%s", var.environment)
  ecs_service_name         = format("tfc_agent_%s", var.environment)
  ecs_task_definition_name = format("tfc_agent_%s", var.environment)

  tfc_agent_pool_name = format("Safepass_Sentinel_%s", var.environment)
  tfc_agent_name      = format("Safepass_Sentinel_%s", var.environment)
}
