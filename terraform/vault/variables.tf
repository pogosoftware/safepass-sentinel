####################################################################################################
### HCP
####################################################################################################
variable "hcp_project_id" {
  description = "The UUID of HCP project"
  type        = string
}

variable "hcp_cloud_workspace_name" {
  description = "The name of hcp cloud workspace"
  type        = string
}

####################################################################################################
### VAULT
####################################################################################################
variable "vault_namespace" {
  description = "The name of vault namespace"
  type        = string
}

variable "vault_ssh_mount_path" {
  default     = "ssh-client-signer"
  description = "The path to SSH Vault mount"
  type        = string
}

variable "vault_ssh_role_name" {
  default     = "boundary-client"
  description = "The name of SSH backend role"
  type        = string
}

variable "vault_ssh_default_user" {
  default     = "ubuntu"
  description = "The SSH default user name"
  type        = string
}
