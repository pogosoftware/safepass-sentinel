output "vault_apps_mount_name" {
  description = "The name of Vault mount for apps"
  value       = var.vault_apps_mount_name
}

output "vault_apps_boundary_secret_name" {
  description = "The name of boundary secret in vault"
  value       = var.vault_apps_boundary_secret_name
}