####################################################################################################
### GLOBAL
####################################################################################################
variable "environment" {
  default     = "dev"
  description = "The Name of environment. Possible values are: `dev`, `stg`, `prd`"
  type        = string
}

####################################################################################################
### HCP
####################################################################################################
variable "hcp_project_id" {
  description = "The UUID of HCP project"
  type        = string
}

variable "hcp_cloud_workspace_name" {
  default     = "hcp-cloud-euc1"
  description = "The name of hcp cloud workspace"
  type        = string
}

####################################################################################################
### VAULT
####################################################################################################
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

variable "vault_apps_mount_name" {
  default     = "apps"
  description = "The name of Vault mount for apps"
  type        = string
}

variable "vault_apps_boundary_secret_name" {
  default     = "infra/boundary"
  description = "The name of boundary secret in vault"
  type        = string
}
