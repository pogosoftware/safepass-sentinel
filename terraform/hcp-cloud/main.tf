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
  cluster_id      = var.hcp_cloud_vault_cluster_id
  hvn_id          = hcp_hvn.this.hvn_id
  public_endpoint = var.hcp_cloud_vault_public_endpoint
  tier            = var.hcp_cloud_vault_tier
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
  cluster_id = var.hcp_cloud_boundary_cluster_id
  username   = local.boundary_username
  password   = local.boundary_password
  tier       = var.hcp_cloud_boundary_tier
}

####################################################################################################
### HCP -> AWS PEERING
####################################################################################################
resource "hcp_aws_network_peering" "peer" {
  hvn_id          = hcp_hvn.this.hvn_id
  peering_id      = var.peering_id
  peer_vpc_id     = local.peer_vpc_id
  peer_account_id = local.peer_account_id
  peer_vpc_region = local.peer_vpc_region
}

resource "hcp_hvn_route" "peer_route" {
  hvn_link         = hcp_hvn.this.self_link
  hvn_route_id     = var.route_id
  destination_cidr = local.peer_destination_cidr
  target_link      = hcp_aws_network_peering.peer.self_link
}

resource "aws_vpc_peering_connection_accepter" "peer" {
  vpc_peering_connection_id = hcp_aws_network_peering.peer.provider_peering_id
  auto_accept               = true
  tags = {
    Name = var.peering_id
  }
}

####################################################################################################
### VAULT
####################################################################################################
resource "vault_namespace" "develop" {
  path = "develop"
}

resource "vault_mount" "apps" {
  namespace = vault_namespace.develop.path
  path      = "apps"
  type      = "kv-v2"
}

resource "vault_kv_secret_v2" "boundary" {
  namespace           = vault_namespace.develop.path
  mount               = vault_mount.apps.path
  name                = "infra/boundary"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      username = local.boundary_username,
      password = local.boundary_password
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      tf_module = "hcp-cloud"
    }
  }
}

####################################################################################################
### VAULT - JWT AUTH ROLE FOR TFC
####################################################################################################
resource "vault_jwt_auth_backend" "jwt" {
  namespace          = vault_namespace.develop.path
  description        = "Dynamic Credentials for Vault provider"
  path               = "jwt"
  oidc_discovery_url = "https://app.terraform.io"
  bound_issuer       = "https://app.terraform.io"
}

resource "vault_policy" "tfc_policy" {
  for_each = var.hcp_vault_variable_set_workspaces

  name      = each.key
  namespace = vault_namespace.develop.path
  policy    = file("templates/${each.key}-policy.hcl")
}

resource "vault_jwt_auth_backend_role" "tfc" {
  for_each = var.hcp_vault_variable_set_workspaces

  namespace      = vault_namespace.develop.path
  backend        = vault_jwt_auth_backend.jwt.path
  role_name      = each.key
  token_policies = [each.key]

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
resource "tfe_variable_set" "vault" {
  for_each = var.hcp_vault_variable_set_workspaces

  name         = "SafaPass Sentinel - Develop - Vault (${each.key}) Credentials"
  description  = "This resource is manage by Terraform"
  organization = data.hcp_organization.this.name
  workspace_ids = [
    data.tfe_workspace_ids.workspaces.ids[each.key]
  ]
}

resource "tfe_variable" "tfc_vault_provider_auth" {
  for_each = var.hcp_vault_variable_set_workspaces

  key             = "TFC_VAULT_PROVIDER_AUTH"
  value           = "true"
  category        = "env"
  variable_set_id = tfe_variable_set.vault[each.key].id
}

resource "tfe_variable" "tfc_vault_addr" {
  for_each = var.hcp_vault_variable_set_workspaces

  key             = "VAULT_ADDR"
  value           = hcp_vault_cluster.this.vault_public_endpoint_url
  category        = "env"
  variable_set_id = tfe_variable_set.vault[each.key].id
}

resource "tfe_variable" "tfc_vault_run_role" {
  for_each = var.hcp_vault_variable_set_workspaces

  key             = "TFC_VAULT_RUN_ROLE"
  value           = each.key
  category        = "env"
  variable_set_id = tfe_variable_set.vault[each.key].id
}
