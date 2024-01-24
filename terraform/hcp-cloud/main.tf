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
resource "hcp_boundary_cluster" "this" {
  cluster_id = var.hcp_cloud_boundary_cluster_id
  username   = local.boundary_username
  password   = local.boundary_password
  tier       = var.hcp_cloud_boundary_tier
}

####################################################################################################
### HCP VAULT SECRETS
####################################################################################################
resource "hcp_vault_secrets_app" "hcp_cloud" {
  app_name    = "hcp-cloud"
  description = "This app contains credentials to HCP Cloud"
}

## HCP Vault
resource "hcp_vault_secrets_secret" "vault_cluster_admin_token" {
  app_name     = hcp_vault_secrets_app.hcp_cloud.app_name
  secret_name  = "vault_cluster_admin_token"
  secret_value = hcp_vault_cluster_admin_token.this.token
}

## HCP Boundary
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

resource "hcp_vault_secrets_secret" "boundary_username" {
  app_name     = hcp_vault_secrets_app.hcp_cloud.app_name
  secret_name  = "boundary_username"
  secret_value = local.boundary_username
}

resource "hcp_vault_secrets_secret" "boundary_password" {
  app_name     = hcp_vault_secrets_app.hcp_cloud.app_name
  secret_name  = "boundary_password"
  secret_value = local.boundary_password
}
