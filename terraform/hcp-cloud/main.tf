# ####################################################################################################
# ### HCP VAULT CLUSTER
# ####################################################################################################
# resource "hcp_hvn" "this" {
#   hvn_id         = var.hcp_cloud_hvn_id
#   cloud_provider = var.hcp_cloud_cloud_provider
#   region         = var.hcp_cloud_region
#   cidr_block     = var.hcp_cloud_cidr_block
# }

# resource "hcp_vault_cluster" "this" {
#   cluster_id      = var.hcp_cloud_vault_cluster_id
#   hvn_id          = hcp_hvn.this.hvn_id
#   public_endpoint = var.hcp_cloud_vault_public_endpoint
#   tier            = var.hcp_cloud_vault_tier
# }

# resource "hcp_vault_cluster_admin_token" "this" {
#   cluster_id = hcp_vault_cluster.this.id
# }

####################################################################################################
### HCP VAULT SECRETS
####################################################################################################
resource "random_string" "boundary_password" {
  length           = 32
  special          = true
  override_special = "/@£$"
}

resource "hcp_vault_secrets_app" "boundary" {
  app_name    = "boundary"
  description = "This app contains credentials to HCP Boundary"
}

resource "hcp_vault_secrets_secret" "boundary_username" {
  app_name     = hcp_vault_secrets_app.boundary.app_name
  secret_name  = "username"
  secret_value = var.boundary_username
}

resource "hcp_vault_secrets_secret" "boundary_password" {
  app_name     = hcp_vault_secrets_app.boundary.app_name
  secret_name  = "password"
  secret_value = random_string.boundary_password.result
}

####################################################################################################
### HCP BOUNDARY CLUSTER
####################################################################################################
resource "hcp_boundary_cluster" "this" {
  cluster_id = var.hcp_cloud_boundary_cluster_id
  username   = var.boundary_username
  password   = random_string.boundary_password.result
  tier       = var.hcp_cloud_boundary_tier
}

####################################################################################################
### HCP BOUNDARY RESOURCES
####################################################################################################
resource "boundary_scope" "org" {
  name                     = var.hcp_boundary_org_name
  description              = var.hcp_boundary_org_description
  scope_id                 = "global"
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_scope" "project" {
  name        = var.hcp_boundary_project_name
  description = var.hcp_boundary_project_description

  scope_id                 = boundary_scope.org.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}