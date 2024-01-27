data "hcp_organization" "this" {}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = var.hcp_network_workspace_name
    }
  }
}

data "terraform_remote_state" "hcp_cloud" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = var.hcp_cloud_workspace_name
    }
  }
}

data "terraform_remote_state" "vault" {
  backend = "remote"

  config = {
    organization = data.hcp_organization.this.name
    workspaces = {
      name = var.hcp_vault_workspace_name
    }
  }
}

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

data "hcp_vault_secrets_secret" "boundary_username" {
  app_name    = data.terraform_remote_state.hcp_cloud.outputs.hcp_cloud_secret_app_name
  secret_name = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_username_secret_name
}

data "hcp_vault_secrets_secret" "boundary_password" {
  app_name    = data.terraform_remote_state.hcp_cloud.outputs.hcp_cloud_secret_app_name
  secret_name = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_password_secret_name
}

data "hcp_vault_secrets_secret" "public_key_openssh" {
  app_name    = data.terraform_remote_state.vault.outputs.vault_secret_app_name
  secret_name = data.terraform_remote_state.vault.outputs.vault_public_key_openssh_secret_name
}