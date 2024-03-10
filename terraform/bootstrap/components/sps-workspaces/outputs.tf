####################################################################################################
### WORKSPACES
####################################################################################################
output "workspaces" {
  value = {
    network = {
      id   = module.network_workspace.id
      name = module.network_workspace.name
    },
    hcp_cloud = {
      id   = module.hcp_cloud_workspace.id
      name = module.hcp_cloud_workspace.name
    },
    vault = {
      id   = module.vault_workspace.id
      name = module.vault_workspace.name
    },
    boundary = {
      id   = module.boundary_workspace.id
      name = module.boundary_workspace.name
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
