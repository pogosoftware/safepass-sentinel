locals {
  hcp_network_workspace_name = format("%s-%s", var.hcp_network_workspace_name, var.environment)

  ecs_cluster_subnet_id = data.terraform_remote_state.hcp_network.outputs.private_subnet_ids[0]
  ecs_cluster_public_subnet_id = data.terraform_remote_state.hcp_network.outputs.public_subnet_ids[0]
  ecs_cluster_sg_id     = data.terraform_remote_state.hcp_network.outputs.security_group_ids["tfc-agent"]

  ecs_execution_role_name  = format("tfc_agent_ecs_execution_%s", var.environment)
  ecs_role_name            = format("tfc_agent_ecs_%s", var.environment)
  ecs_cluster_name         = format("tfc_agent_%s", var.environment)
  ecs_service_name         = format("tfc_agent_%s", var.environment)
  ecs_task_definition_name = format("tfc_agent_%s", var.environment)

  tfc_agent_pool_name = format("safepass_sentinel_%s", var.environment)
  tfc_agent_name      = format("SafePass_Sentinel_%s", var.environment)
}

########################################################################################################################
### TFC AGENT POOL
########################################################################################################################
resource "tfe_agent_pool" "this" {
  name                = local.tfc_agent_pool_name
  organization        = data.hcp_organization.this.name
  organization_scoped = true
}

resource "tfe_agent_token" "this" {
  agent_pool_id = tfe_agent_pool.this.id
  description   = local.tfc_agent_pool_name
}

########################################################################################################################
## IAM Role for ECS Task execution
########################################################################################################################
resource "aws_iam_role" "ecs_execution" {
  name               = local.ecs_execution_role_name
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

########################################################################################################################
## IAM Role for ECS Task
########################################################################################################################
resource "aws_iam_role" "ecs" {
  name               = local.ecs_role_name
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}

########################################################################################################################
## Creates an ECS Cluster
########################################################################################################################
resource "aws_ecs_cluster" "this" {
  name = local.ecs_cluster_name

  tags = {
    Name = local.ecs_cluster_name
  }
}

########################################################################################################################
## Creates ECS Task Definition
########################################################################################################################
resource "aws_ecs_task_definition" "this" {
  family                   = local.ecs_task_definition_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  cpu                      = var.cpu_units
  memory                   = var.memory
  container_definitions = jsonencode(
    [
      {
        name : local.tfc_agent_name
        image : var.image
        essential : true
        cpu : var.cpu_units
        memory : var.memory
        logConfiguration : {
          logDriver : "awslogs",
          options : {
            awslogs-create-group : "true",
            awslogs-group : "awslogs-tfc-agent"
            awslogs-region : var.aws_region
            awslogs-stream-prefix : "awslogs-tfc-agent"
          }
        }
        environment = [
          {
            name  = "TFC_AGENT_SINGLE",
            value = "true"
          },
          {
            name  = "TFC_AGENT_NAME",
            value = local.tfc_agent_name
          }
        ]
        secrets = [
          {
            name      = "TFC_AGENT_TOKEN",
            valueFrom = tfe_agent_token.this.token
          }
        ]
      }
    ]
  )

  tags = {
    Name = local.ecs_task_definition_name
  }
}

########################################################################################################################
## Creates ECS Service
########################################################################################################################
resource "aws_ecs_service" "this" {
  name            = local.ecs_service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.ecs_task_desired_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [local.ecs_cluster_sg_id]
    subnets          = [local.ecs_cluster_public_subnet_id, local.ecs_cluster_subnet_id]
    assign_public_ip = true
  }

  tags = {
    Name = local.ecs_service_name
  }
}
