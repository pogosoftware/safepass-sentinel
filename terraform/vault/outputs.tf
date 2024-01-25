####################################################################################################
### HCP CLOUD
####################################################################################################
output "vault_namespace" {
  description = "The name of vault namespace"
  value       = vault_namespace.this.path_fq
}

output "vault_secret_app_name" {
  description = "The name od Vault Secrets app"
  value       = hcp_vault_secrets_app.vault.app_name
}

### VAULT
output "vault_public_key_openssh_secret_name" {
  description = "The app secret name of vault public ssh key"
  value       = hcp_vault_secrets_secret.vault_public_key_openssh.secret_name
}

output "vault_private_key_openssh_secret_name" {
  description = "The app secret name of vault private ssh key"
  value       = hcp_vault_secrets_secret.vault_private_key_openssh.secret_name
}

output "vault_boundary_client_token_secret_name" {
  description = "The app secret name of boundary client token"
  value       = hcp_vault_secrets_secret.vault_boundary_client_token.secret_name
}