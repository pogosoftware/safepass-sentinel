####################################################################################################
### WORKSPACES
####################################################################################################
output "workspaces" {
  value = {
    network = {
      id   = try(module.network_workspace.id, null)
      name = try(module.network_workspace.name, null)
    },
    hcp_cloud = {
      id   = try(module.hcp_cloud_workspace.id, null)
      name = try(module.hcp_cloud_workspace.name, null)
    },
    vault = {
      id   = try(module.vault_workspace.id, null)
      name = try(module.vault_workspace.name, null)
    },
    boundary = {
      id   = try(module.boundary_workspace.id, null)
      name = try(module.boundary_workspace.name, null)
    }
  }
}

####################################################################################################
### IAM USERS
####################################################################################################
output "boundary_user_access_key_id" {
  description = "The access key ID"
  sensitive   = true
  value       = module.boundary_user.iam_access_key_id
}

output "boundary_user_access_key_secret" {
  description = "The access key secret"
  sensitive   = true
  value       = module.boundary_user.iam_access_key_secret
}
