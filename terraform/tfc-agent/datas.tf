data "hcp_organization" "this" {}

####################################################################################################
### REMOTE STATES
####################################################################################################
data "terraform_remote_state" "hcp_network" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = local.hcp_network_workspace_name
    }
  }
}

########################################################################################################################
## IAM Role for ECS Task execution
########################################################################################################################
data "aws_iam_policy_document" "task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
