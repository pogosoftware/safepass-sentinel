####################################################################################################
### HCP BOUNDARY
####################################################################################################
output "hcp_boundary_cluster_id" {
  description = "The ID of HCP Boundary cluster"
  value       = join("", regex("https://([a-f0-9-]+)\\.boundary\\.hashicorp\\.cloud", hcp_boundary_cluster.this.cluster_url))
}

output "hcp_boundary_cluster_url" {
  description = "The URL to HCP Boundary"
  value       = hcp_boundary_cluster.this.cluster_url
}

output "hcp_boundary_username" {
  description = "The name of HCP Boundary"
  value       = local.boundary_username
}

output "hcp_boundary_password" {
  description = "The name of HCP Boundary"
  value       = local.boundary_password
  sensitive   = true
}

####################################################################################################
### HCP VAULT
####################################################################################################
output "hcp_vault_private_endpoint_url" {
  description = "The private URL to HCP Vault cluster"
  value       = hcp_vault_cluster.this.vault_private_endpoint_url
}

output "hcp_vault_env_namespace_path" {
  description = "The path to the environment namespace"
  value       = vault_namespace.env.path
}

output "hcp_vault_env_namespace_path_fq" {
  description = "The fully qualified path to the environment namespace"
  value       = vault_namespace.env.path_fq
}

output "hcp_vault_devops_namespace_path" {
  description = "The path to the devops namespace"
  value       = vault_namespace.devops.path
}

output "hcp_vault_devops_namespace_path_fq" {
  description = "The fully qualified path to the devops namespace"
  value       = vault_namespace.devops.path_fq
}
