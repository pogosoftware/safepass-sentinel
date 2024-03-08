data "hcp_organization" "this" {}

####################################################################################################
### REMOTE STATES
####################################################################################################
data "terraform_remote_state" "bootstrap" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = local.bootstrap_workspace_name
    }
  }
}

data "terraform_remote_state" "hcp_cloud" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = data.terraform_remote_state.bootstrap.outputs.hcp_cloud_workspace_name
    }
  }
}

data "terraform_remote_state" "hcp_vault" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = data.terraform_remote_state.bootstrap.outputs.vault_workspace_name
    }
  }
}

data "terraform_remote_state" "hcp_network" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = data.terraform_remote_state.bootstrap.outputs.network_workspace_name
    }
  }
}

####################################################################################################
### VAULT SECRETS
####################################################################################################
data "vault_kv_secret_v2" "boundary" {
  mount = local.boundary_vault_mount_name
  name  = local.boundary_vault_secret_name
}

####################################################################################################
### IAM AMIS
####################################################################################################
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
