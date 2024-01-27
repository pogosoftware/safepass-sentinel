####################################################################################################
### HCP
####################################################################################################
variable "hcp_project_id" {
  description = "The UUID of HCP project"
  type        = string
}

variable "hcp_cloud_workspace_name" {
  description = "The name of hcp-cloud TFC workspace"
  type        = string
}

variable "hcp_vault_workspace_name" {
  description = "The name of vault TFC workspace"
  type        = string
}

variable "hcp_network_workspace_name" {
  description = "The name of network TFC workspace"
}

####################################################################################################
### BOUNDARY WORKER
####################################################################################################
variable "boundary_workers_egress_name" {
  default     = "boundary-egress-worker"
  description = "The name of Boundary egress worker"
  type        = string
}

variable "boundary_workers_instance_type" {
  default     = "t2.micro"
  description = "The type of Boundary worker instance"
  type        = string
}
