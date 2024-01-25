####################################################################################################
### HCP CLOUD
####################################################################################################
output "hcp_cloud_secret_app_name" {
  description = "The name od Vault Secrets app"
  value       = hcp_vault_secrets_app.hcp_cloud.app_name
}

# ####################################################################################################
# ### AWS SSM
# ####################################################################################################
output "ssm_hcp_client_id_name" {
  description = "The name of SSM HCP client ID param"
  value       = var.ssm_hcp_client_id_name
}

output "ssm_hcp_client_secret_name" {
  description = "The name of SSM HCP client secret param"
  value       = var.ssm_hcp_client_secret_name
}

####################################################################################################
### HCP BOUNDARY
####################################################################################################
output "hcp_boundary_cluster_id" {
  description = "The ID of HCP Boudary cluster"
  value       = join("", regex("https://([a-f0-9-]+)\\.boundary\\.hashicorp\\.cloud", hcp_boundary_cluster.this.cluster_url))
}

output "hcp_boundary_cluster_url" {
  description = "The URL to HCP Boudary"
  value       = hcp_boundary_cluster.this.cluster_url
}

output "hcp_boundary_username_secret_name" {
  description = "The app secret name of boundary username"
  value       = hcp_vault_secrets_secret.boundary_username.secret_name
}

output "hcp_boundary_password_secret_name" {
  description = "The app secret name of boundary password"
  value       = hcp_vault_secrets_secret.boundary_password.secret_name
}

####################################################################################################
### HCP VAULT
####################################################################################################
output "hcp_vault_public_endpoint_url" {
  description = "The public URL to HCP Vault cluster"
  value       = hcp_vault_cluster.this.vault_public_endpoint_url
}

output "hcp_vault_cluster_admin_token_secret_name" {
  description = "The app secret name of vault cluster admin token"
  value       = hcp_vault_secrets_secret.vault_cluster_admin_token.secret_name
}