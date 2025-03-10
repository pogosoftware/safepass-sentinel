####################################################################################################
### AWS ROLES
####################################################################################################
module "network_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "4.0.1"

  create_iam_role        = local.create_network_workspace
  name_preffix           = local.network_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.network_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.network_apply.json

  tfe_project   = local.hcp_project_name
  tfe_workspace = local.network_workspace_name
}

module "hcp_cloud_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "4.0.1"

  create_iam_role        = local.create_hcp_cloud_workspace
  name_preffix           = local.hcp_cloud_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.hcp_cloud_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.hcp_cloud_apply.json

  tfe_project   = local.hcp_project_name
  tfe_workspace = local.hcp_cloud_workspace_name
}

module "boundary_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "4.0.1"

  create_iam_role        = local.create_boundary_workspace
  name_preffix           = local.boundary_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.boundary_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.boundary_apply.json

  tfe_project   = local.hcp_project_name
  tfe_workspace = local.boundary_workspace_name
}

module "tfc_agent_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "4.0.1"

  create_iam_role        = local.create_tfc_agent_workspace
  name_preffix           = local.tfc_agent_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.tfc_agent_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.tfc_agent_apply.json

  tfe_project   = local.hcp_project_name
  tfe_workspace = local.tfc_agent_workspace_name
}

module "database_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "4.0.1"

  create_iam_role        = local.create_database_workspace
  name_preffix           = local.database_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.database_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.database_apply.json

  tfe_project   = local.hcp_project_name
  tfe_workspace = local.database_workspace_name
}

####################################################################################################
### IAM USERS
####################################################################################################
module "boundary_describe_instances_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.53.0"

  create_policy = true
  name          = "boundary"

  policy = data.aws_iam_policy_document.boudary_describe_instances.json
}

module "boundary_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.53.0"

  create_user = true
  name        = "boundary"

  create_iam_access_key         = true
  create_iam_user_login_profile = false
  policy_arns = [
    module.boundary_describe_instances_policy.arn
  ]
}

####################################################################################################
### TFE WORKSPACES
####################################################################################################
module "network_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "4.0.1"

  create_workspace           = local.create_network_workspace
  name                       = local.network_workspace_name
  project_id                 = data.tfe_project.this.id
  working_directory          = "./terraform/network"
  trigger_patterns           = ["./terraform/network/*.tf"]
  vcs_repos                  = var.vcs_repo
  allow_destroy_plan         = var.allow_destroy_plan
  auto_apply                 = var.auto_apply
  terraform_reqiured_version = var.terraform_version

  workspace_variables = {
    TFC_AWS_PLAN_ROLE_ARN = {
      value    = module.network_role.plan_role_arn
      category = "env"
    },
    TFC_AWS_APPLY_ROLE_ARN = {
      value    = module.network_role.apply_role_arn
      category = "env"
    }
  }

  share_state_with_workspace_ids = [
    local.create_hcp_cloud_workspace ? module.hcp_cloud_workspace.id : null,
    local.create_boundary_workspace ? module.boundary_workspace.id : null,
    local.create_tfc_agent_workspace ? module.tfc_agent_workspace.id : null,
    local.create_database_workspace ? module.database_workspace.id : null
  ]
}

module "hcp_cloud_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "4.0.1"

  create_workspace           = local.create_hcp_cloud_workspace
  name                       = local.hcp_cloud_workspace_name
  project_id                 = data.tfe_project.this.id
  working_directory          = "./terraform/hcp-cloud"
  trigger_patterns           = ["./terraform/hcp-cloud/*.tf"]
  vcs_repos                  = var.vcs_repo
  tags                       = ["deps:network", "deps:tfc-agent"]
  allow_destroy_plan         = var.allow_destroy_plan
  auto_apply                 = var.auto_apply
  terraform_reqiured_version = var.terraform_version

  workspace_variables = {
    TFC_AWS_PLAN_ROLE_ARN = {
      value    = module.hcp_cloud_role.plan_role_arn
      category = "env"
    },
    TFC_AWS_APPLY_ROLE_ARN = {
      value    = module.hcp_cloud_role.apply_role_arn
      category = "env"
    },
    bootstrap_workspace_name = {
      value    = terraform.workspace
      category = "terraform"
    }
  }

  share_state_with_workspace_ids = [
    local.create_vault_workspace ? module.vault_workspace.id : null,
    local.create_boundary_workspace ? module.boundary_workspace.id : null
  ]
}

module "vault_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "4.0.1"

  create_workspace           = local.create_vault_workspace
  name                       = local.vault_workspace_name
  project_id                 = data.tfe_project.this.id
  working_directory          = "./terraform/vault"
  trigger_patterns           = ["./terraform/vault/*.tf"]
  vcs_repos                  = var.vcs_repo
  tags                       = ["deps:hcp-cloud", "deps:database"]
  allow_destroy_plan         = var.allow_destroy_plan
  auto_apply                 = var.auto_apply
  terraform_reqiured_version = var.terraform_version

  workspace_variables = {
    bootstrap_workspace_name = {
      value    = terraform.workspace
      category = "terraform"
    }
  }

  share_state_with_workspace_ids = [
    module.boundary_workspace != null ? module.boundary_workspace.id : null
  ]
}

module "boundary_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "4.0.1"

  create_workspace           = local.create_boundary_workspace
  name                       = local.boundary_workspace_name
  project_id                 = data.tfe_project.this.id
  working_directory          = "./terraform/boundary"
  trigger_patterns           = ["./terraform/boundary/*.tf"]
  vcs_repos                  = var.vcs_repo
  tags                       = ["deps:hcp-cloud", "deps:network", "deps:vault"]
  allow_destroy_plan         = var.allow_destroy_plan
  auto_apply                 = var.auto_apply
  terraform_reqiured_version = var.terraform_version

  workspace_variables = {
    TFC_AWS_PLAN_ROLE_ARN = {
      value    = module.boundary_role.plan_role_arn
      category = "env"
    },
    TFC_AWS_APPLY_ROLE_ARN = {
      value    = module.boundary_role.apply_role_arn
      category = "env"
    },
    bootstrap_workspace_name = {
      value    = terraform.workspace
      category = "terraform"
    }
  }
}

module "tfc_agent_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "4.0.1"

  create_workspace           = local.create_tfc_agent_workspace
  name                       = local.tfc_agent_workspace_name
  project_id                 = data.tfe_project.this.id
  working_directory          = "./terraform/tfc-agent"
  trigger_patterns           = ["./terraform/tfc-agent/*.tf"]
  vcs_repos                  = var.vcs_repo
  tags                       = ["deps:network"]
  allow_destroy_plan         = var.allow_destroy_plan
  auto_apply                 = var.auto_apply
  terraform_reqiured_version = var.terraform_version

  workspace_variables = {
    TFC_AWS_PLAN_ROLE_ARN = {
      value    = module.tfc_agent_role.plan_role_arn
      category = "env"
    },
    TFC_AWS_APPLY_ROLE_ARN = {
      value    = module.tfc_agent_role.apply_role_arn
      category = "env"
    },
    bootstrap_workspace_name = {
      value    = terraform.workspace
      category = "terraform"
    }
  }
}

module "database_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "4.0.1"

  create_workspace           = local.create_database_workspace
  name                       = local.database_workspace_name
  project_id                 = data.tfe_project.this.id
  working_directory          = "./terraform/database"
  trigger_patterns           = ["./terraform/database/*.tf"]
  vcs_repos                  = var.vcs_repo
  tags                       = ["deps:network"]
  allow_destroy_plan         = var.allow_destroy_plan
  auto_apply                 = var.auto_apply
  terraform_reqiured_version = var.terraform_version

  workspace_variables = {
    TFC_AWS_PLAN_ROLE_ARN = {
      value    = module.database_role.plan_role_arn
      category = "env"
    },
    TFC_AWS_APPLY_ROLE_ARN = {
      value    = module.database_role.apply_role_arn
      category = "env"
    },
    bootstrap_workspace_name = {
      value    = terraform.workspace
      category = "terraform"
    }
  }

  share_state_with_workspace_ids = [
    local.create_vault_workspace ? module.vault_workspace.id : null,
    local.create_boundary_workspace ? module.boundary_workspace.id : null
  ]
}
