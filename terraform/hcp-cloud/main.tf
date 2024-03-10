# ####################################################################################################
# ### HCP VAULT CLUSTER
# ####################################################################################################
resource "hcp_hvn" "this" {
  hvn_id         = var.hcp_cloud_hvn_id
  cloud_provider = var.hcp_cloud_cloud_provider
  region         = var.hcp_cloud_region
  cidr_block     = var.hcp_cloud_cidr_block
}

resource "hcp_vault_cluster" "this" {
  cluster_id      = local.vault_cluster_id
  hvn_id          = hcp_hvn.this.hvn_id
  public_endpoint = var.vault_public_endpoint
  tier            = var.vault_tier
}

resource "hcp_vault_cluster_admin_token" "this" {
  cluster_id = hcp_vault_cluster.this.cluster_id
}

####################################################################################################
### HCP BOUNDARY CLUSTER
####################################################################################################
resource "random_string" "boundary_username" {
  length  = 16
  special = false
  upper   = false
}

resource "random_password" "boundary_password" {
  length           = 32
  special          = true
  override_special = "/@£$"
}

resource "hcp_boundary_cluster" "this" {
  cluster_id = local.boundary_cluster_id
  username   = local.boundary_username
  password   = local.boundary_password
  tier       = var.boundary_tier
}

####################################################################################################
### HCP -> AWS PEERING
####################################################################################################
resource "hcp_aws_network_peering" "peer" {
  hvn_id          = hcp_hvn.this.hvn_id
  peering_id      = local.peering_id
  peer_vpc_id     = local.peer_vpc_id
  peer_account_id = local.peer_account_id
  peer_vpc_region = local.peer_vpc_region
}

resource "hcp_hvn_route" "peer_route" {
  hvn_link         = hcp_hvn.this.self_link
  hvn_route_id     = local.route_id
  destination_cidr = local.peer_destination_cidr
  target_link      = hcp_aws_network_peering.peer.self_link
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = hcp_aws_network_peering.peer.provider_peering_id
  auto_accept               = true
  tags = {
    Name = local.peering_id
  }
}

resource "aws_route" "private_to_hvn" {
  for_each = local.private_route_table_ids

  route_table_id            = aws_route_table.testing.id
  destination_cidr_block    = var.hcp_cloud_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection_accepter.peer.vpc_peering_connection_id
}

####################################################################################################
### VAULT - JWT AUTH ROLE FOR TFC
####################################################################################################
resource "vault_namespace" "env" {
  path = var.environment
}

resource "vault_namespace" "devops" {
  namespace = vault_namespace.env.path
  path      = "devops"
}

resource "vault_jwt_auth_backend" "jwt" {
  namespace          = vault_namespace.devops.path_fq
  description        = "Dynamic Credentials for Vault provider"
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_policy" "workspaces" {
  for_each = local.vault_jwt_roles

  name      = each.value.name
  namespace = vault_namespace.devops.path_fq
  policy    = file("templates/${each.key}-policy.hcl")
}

resource "vault_jwt_auth_backend_role" "workspaces" {
  for_each = local.vault_jwt_roles

  namespace      = vault_namespace.devops.path_fq
  backend        = vault_jwt_auth_backend.jwt.path
  role_name      = each.value.name
  token_policies = ["default", each.value.name]

  bound_audiences   = ["vault.workload.identity"]
  bound_claims_type = "glob"
  bound_claims = {
    sub = "organization:${data.hcp_organization.this.name}:project:${data.hcp_project.this.name}:workspace:*:run_phase:*"
  }
  user_claim = "terraform_full_workspace"
  role_type  = "jwt"
  token_ttl  = 1200
}

####################################################################################################
### CREATE VARABLE SETS WITH VAULT CREDENTIALS
####################################################################################################
module "vault_credentials_variable_set" {
  source  = "pogosoftware/tfe/tfe//modules/variable-set"
  version = "1.3.0"

  name        = format("SafaPass Sentinel - %s - Vault Credentials", var.environment)
  description = "This resource is manage by Terraform"

  variables = {
    TFC_VAULT_PROVIDER_AUTH = {
      value    = true
      category = "env"
    },
    TFC_VAULT_ADDR = {
      value    = hcp_vault_cluster.this.vault_public_endpoint_url
      category = "env"
    },
    TFC_VAULT_NAMESPACE = {
      value    = format("admin/%s", vault_namespace.devops.path_fq)
      category = "env"
    }
  }

  workspace_ids = [for x in local.vault_jwt_roles : x.id]
}

resource "tfe_variable" "tfe_vault_run_role_workspace_variable" {
  for_each = { for x in local.vault_jwt_roles : x.name => x.id }

  key          = "TFC_VAULT_RUN_ROLE"
  value        = each.key
  category     = "env"
  workspace_id = each.value
}