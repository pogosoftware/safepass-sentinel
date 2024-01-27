variable "environment" {
  description = "The name of environment"
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
variable "boundary_asg_name" {
  default     = "boundary-egress-worker"
  description = "The name of ASG Boundary egress workers"
  type        = string
}

variable "boundary_workers_instance_type" {
  default     = "t2.micro"
  description = "The type of Boundary worker instance"
  type        = string
}

variable "boundary_asg_min_size" {
  default     = 0
  description = "The ASG min size"
  type        = number
}

variable "boundary_asg_max_size" {
  default     = 2
  description = "The ASG max size"
  type        = number
}

variable "boundary_asg_desired_capacity" {
  default     = 2
  description = "The ASG desired size"
  type        = number
}
