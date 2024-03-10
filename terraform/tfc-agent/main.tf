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

resource "aws_ssm_parameter" "agent_token" {
  name        = "/secret/terraform/agent-token-${var.environment}"
  description = "Terraform Cloud agent token"
  type        = "SecureString"
  value       = tfe_agent_token.this.token
}

########################################################################################################################
## IAM Role for ECS Task execution
########################################################################################################################
resource "aws_iam_role" "tfc_agents" {
  name               = local.ecs_cluster_role_name
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "tfc_agents_task_execution_role" {
  role       = aws_iam_role.tfc_agents.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "tfs_agents_inline" {
  name   = "additional_permissions"
  role   = aws_iam_role.tfc_agents.name
  policy = data.aws_iam_policy_document.tfc_agent_inline.json
}

########################################################################################################################
## IAM Role for ECS Task
########################################################################################################################
resource "aws_iam_role" "ecs_task" {
  name               = local.ecs_task_role_name
  assume_role_policy = data.aws_iam_policy_document.task_assume_role_policy.json
}

########################################################################################################################
## SECURITY GROUP RULES
########################################################################################################################
resource "aws_security_group_rule" "allow_443_egress" {
  type              = "egress"
  to_port           = 443
  protocol          = "-1"
  from_port         = 443
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.ecs_cluster_sg_id
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
  execution_role_arn       = aws_iam_role.tfc_agents.arn
  cpu    = var.cpu_units
  memory = var.memory
  container_definitions = jsonencode(
    [
      {
        name : local.tfc_agent_name
        image : var.image
        cpu : var.cpu_units,
        memory : var.memory,
        essential : true,
        environment = [
          {
            name  = "TFC_ADDRESS",
            value = "https://app.terraform.io"
          },
          {
            name  = "TFC_AGENT_NAME",
            value = "tfc-agent"
          }
        ]
        secrets = [
          {
            name      = "TFC_AGENT_TOKEN",
            valueFrom = aws_ssm_parameter.agent_token.arn
          }
        ]
        logConfiguration : {
          logDriver : "awslogs",
          options : {
            awslogs-create-group : "true",
            awslogs-group : "/aws/fargate/service/tfc-agent-ecs"
            awslogs-region : var.aws_region
            awslogs-stream-prefix : "tfc-agent"
          }
        }
      }
    ]
  )

  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }

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

  capacity_provider_strategy {
    weight            = 1
    capacity_provider = "FARGATE"
  }

  network_configuration {
    security_groups  = [local.ecs_cluster_sg_id]
    subnets          = [local.ecs_cluster_private_subnet_id]
    assign_public_ip = false
  }

  tags = {
    Name = local.ecs_service_name
  }
}
