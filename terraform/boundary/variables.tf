####################################################################################################
### GLOBAL
####################################################################################################
variable "environment" {
  default     = "dev"
  description = "The Name of environment. Possible values are: `dev`, `stg`, `prd`"
  type        = string
}

variable "bootstrap_workspace_name" {
  description = "The name of bootstrap workspace"
  type        = string
}

####################################################################################################
### HCP
####################################################################################################
variable "hcp_project_id" {
  description = "The UUID of HCP project"
  type        = string
}

####################################################################################################
### HCP BOUNDARY RESOURCES
####################################################################################################
variable "hcp_boundary_org_name" {
  default     = "Pogosoftware"
  description = "The name of Boundary organization"
  type        = string
}

variable "hcp_boundary_org_description" {
  default     = "Pogosoftware"
  description = "The description of Boundary orgranization"
  type        = string
}

variable "hcp_boundary_project_name" {
  default     = "SafePass Sentinel Develop"
  description = "The name of Boundary project"
  type        = string
}

variable "hcp_boundary_project_description" {
  default     = "Contains develop resources for SafePass Sentinel project"
  description = "The description of Boundary project"
  type        = string
}

variable "sync_interval_seconds" {
  default     = 60
  description = "Number of seconds between the time Boundary syncs hosts in this set"
  type        = number
}
####################################################################################################
### AWS
####################################################################################################
variable "aws_region" {
  default     = "eu-central-1"
  description = "The Name of AWS region"
  type        = string
}

variable "boundary_ec2_workers_egress_name" {
  default     = "boundary-egress-worker"
  description = "The name of Boundary egress worker"
  type        = string
}

variable "boundary_ec2_workers_instance_type" {
  default     = "t2.micro"
  description = "The type of Boundary worker instance"
  type        = string
}
