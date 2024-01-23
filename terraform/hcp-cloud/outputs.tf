output "hcp_boundary_cluster_id" {
  description = "The ID of HCP Boudary cluster"
  value       = join("", regex("https://([a-f0-9-]+)\\.boundary\\.hashicorp\\.cloud", hcp_boundary_cluster.this.cluster_url))
}

output "hcp_boundary_cluster_url" {
  description = "The URL to HCP Boudary"
  value       = hcp_boundary_cluster.this.cluster_url
}

### HCP VAULT
output "hcp_vault_public_endpoint_url" {
  description = "The public URL to HCP Vault cluster"
  value       = hcp_vault_cluster.this.vault_public_endpoint_url
}

output "hcp_vault_cluster_admin_token" {
  description = "The admin token to HCP Vault cluster"
  value       = hcp_vault_cluster_admin_token.this.token
  sensitive   = true
}

output "hcp_vault_public_key_openssh" {
  description = "The public SSH key using to sign SSH certificates"
  value       = tls_private_key.vault.public_key_openssh
  sensitive   = true
}