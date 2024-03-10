####################################################################################################
### AWS ROLES
####################################################################################################
module "network_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "1.3.0"

  name_preffix           = local.network_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.network_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.network_apply.json

  tfe_project   = local.tfe_project_name
  tfe_workspace = local.network_workspace_name
}

module "hcp_cloud_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "1.3.0"

  name_preffix           = local.hcp_cloud_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.hcp_cloud_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.hcp_cloud_apply.json

  tfe_project   = local.tfe_project_name
  tfe_workspace = local.hcp_cloud_workspace_name
}

# module "vpn_role" {
#   source  = "pogosoftware/tfe/tfe//modules/iam-role"
#   version = "1.1.1"

#   name_preffix           = local.vpn_workspace_name
#   plan_role_policy_json  = data.aws_iam_policy_document.vpn_plan.json
#   apply_role_policy_json = data.aws_iam_policy_document.vpn_apply.json

#   tfe_project   = local.tfe_project_name
#   tfe_workspace = local.vpn_workspace_name
# }

module "boundary_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "1.3.0"

  name_preffix           = local.boundary_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.boundary_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.boundary_apply.json

  tfe_project   = local.tfe_project_name
  tfe_workspace = local.boundary_workspace_name
}

module "tfc_agent_role" {
  source  = "pogosoftware/tfe/tfe//modules/iam-role"
  version = "1.3.0"

  name_preffix           = local.tfc_agent_workspace_name
  plan_role_policy_json  = data.aws_iam_policy_document.tfc_agent_plan.json
  apply_role_policy_json = data.aws_iam_policy_document.tfc_agent_apply.json

  tfe_project   = local.tfe_project_name
  tfe_workspace = local.tfc_agent_workspace_name
}

####################################################################################################
### IAM USERS
####################################################################################################
module "boundary_describe_instances_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.37.1"

  create_policy = true
  name          = "boundary"

  policy = data.aws_iam_policy_document.boudary_describe_instances.json
}

module "boundary_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.37.1"

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
  version = "1.3.0"

  project_id         = data.tfe_project.this.id
  workspace          = local.network_workspace_name
  working_directory  = "./terraform/network"
  trigger_patterns   = ["./terraform/network/*.tf"]
  vcs_repos          = var.vcs_repo
  tag_names          = ["sps", "aws", var.environment]
  allow_destroy_plan = var.allow_destroy_plan
  auto_apply         = var.auto_apply

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

  remote_state_consumer_ids = [
    module.hcp_cloud_workspace.id,
    module.boundary_workspace.id,
    module.tfc_agent_workspace.id
  ]
}

module "hcp_cloud_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "1.3.0"

  project_id         = data.tfe_project.this.id
  workspace          = local.hcp_cloud_workspace_name
  working_directory  = "./terraform/hcp-cloud"
  trigger_patterns   = ["./terraform/hcp-cloud/*.tf"]
  vcs_repos          = var.vcs_repo
  tag_names          = ["sps", "hcp", var.environment]
  allow_destroy_plan = var.allow_destroy_plan
  auto_apply         = var.auto_apply

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

  remote_state_consumer_ids = [
    module.vault_workspace.id,
    module.boundary_workspace.id
  ]
}

module "vault_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "1.3.0"

  project_id         = data.tfe_project.this.id
  workspace          = local.vault_workspace_name
  working_directory  = "./terraform/vault"
  trigger_patterns   = ["./terraform/vault/*.tf"]
  vcs_repos          = var.vcs_repo
  tag_names          = ["sps", "hcp", var.environment]
  allow_destroy_plan = var.allow_destroy_plan
  auto_apply         = var.auto_apply

  workspace_variables = {
    bootstrap_workspace_name = {
      value    = terraform.workspace
      category = "terraform"
    }
  }

  remote_state_consumer_ids = [
    module.boundary_workspace.id
  ]
}

module "boundary_workspace" {
  source  = "pogosoftware/tfe/tfe//modules/workspace"
  version = "1.3.0"

  project_id         = data.tfe_project.this.id
  workspace          = local.boundary_workspace_name
  working_directory  = "./terraform/boundary"
  trigger_patterns   = ["./terraform/boundary/*.tf"]
  vcs_repos          = var.vcs_repo
  tag_names          = ["sps", "hcp", var.environment]
  allow_destroy_plan = var.allow_destroy_plan
  auto_apply         = var.auto_apply

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
  version = "1.3.0"

  project_id         = data.tfe_project.this.id
  workspace          = local.tfc_agent_workspace_name
  working_directory  = "./terraform/tfc-agent"
  trigger_patterns   = ["./terraform/tfc-agent/*.tf"]
  vcs_repos          = var.vcs_repo
  tag_names          = ["sps", "aws", var.environment]
  allow_destroy_plan = var.allow_destroy_plan
  auto_apply         = var.auto_apply

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
# module "vpn_workspace" {
#   source  = "pogosoftware/tfe/tfe//modules/workspace"
#   version = "1.1.1"

#   project_id        = data.tfe_project.this.id
#   workspace         = local.vpn_workspace_name
#   working_directory = "./terraform/vpn"
#   trigger_patterns  = ["./terraform/vpn/*.tf"]
#   vcs_repos         = var.vcs_repo
#   tag_names         = ["aws", var.environment]

#   aws_provider_auth  = true
#   aws_plan_role_arn  = module.vpn_role.plan_role_arn
#   aws_apply_role_arn = module.vpn_role.apply_role_arn

#   workspace_variables = {
#     network_workspace_name = {
#       value = local.network_workspace_name
#       category = "terraform"
#     }
#   }
# }

####################################################################################################
### TFE VARIABLE SETS
####################################################################################################
module "aws_credentials_variable_set" {
  source  = "pogosoftware/tfe/tfe//modules/variable-set"
  version = "1.3.0"

  name        = format("%s - %s - AWS Credentials", var.tfe_project_name, var.environment)
  description = "Credentials to AWS"

  variables = {
    TFC_AWS_PROVIDER_AUTH = {
      value    = true
      category = "env"
    },
    TFC_AWS_WORKLOAD_IDENTITY_AUDIENCE = {
      value    = var.aws_workload_identity_audience
      category = "env"
    },
    aws_region = {
      value    = var.aws_region
      category = "terraform"
    }
  }

  workspace_ids = [
    module.network_workspace.id,
    module.hcp_cloud_workspace.id,
    module.boundary_workspace.id,
    module.tfc_agent_workspace.id
  ]
}

module "hcp_credentials_variable_set" {
  source  = "pogosoftware/tfe/tfe//modules/variable-set"
  version = "1.3.0"

  name        = format("%s - %s - HCP Credentials", var.tfe_project_name, var.environment)
  description = "Credentials to HCP Cloud"

  variables = {
    HCP_CLIENT_ID = {
      value     = var.hcp_client_id
      category  = "env"
      sensitive = true
    },
    HCP_CLIENT_SECRET = {
      value     = var.hcp_client_secret
      category  = "env"
      sensitive = true
    },
    TFE_TOKEN = {
      value     = var.tfe_token
      category  = "env"
      sensitive = true
    }
  }

  workspace_ids = [
    module.hcp_cloud_workspace.id,
    module.vault_workspace.id,
    module.boundary_workspace.id,
    module.tfc_agent_workspace.id
  ]
}

module "hcp_project_id_variable_set" {
  source  = "pogosoftware/tfe/tfe//modules/variable-set"
  version = "1.3.0"

  name        = format("%s - %s - HCP Project ID", var.tfe_project_name, var.environment)
  description = "ID of HCP Cloud project"

  variables = {
    hcp_project_id = {
      value    = var.hcp_project_id
      category = "terraform"
    }
  }

  workspace_ids = [
    module.hcp_cloud_workspace.id,
    module.vault_workspace.id,
    module.boundary_workspace.id,
    module.tfc_agent_workspace.id
  ]
}
