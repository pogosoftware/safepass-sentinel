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
  description = "The name of hcp-cloud TFC workspace"
  type        = string
}

variable "hcp_vault_workspace_name" {
  default     = "vault-euc1"
  description = "The name of vault TFC workspace"
  type        = string
}

variable "hcp_network_workspace_name" {
  default     = "network-euc1"
  description = "The name of network TFC workspace"
  type        = string
}

####################################################################################################
### HCP BOUNDARY RESOURCES
####################################################################################################
variable "hcp_boundary_org_name" {
  default     = "Pogosoftware"
  description = "The name of Boudary organization"
  type        = string
}

variable "hcp_boundary_org_description" {
  default     = "Pogosoftware"
  description = "The description of Bondary orgranization"
  type        = string
}

variable "hcp_boundary_project_name" {
  default     = "SafePass Sentinel Develop"
  description = "The name of Boudary project"
  type        = string
}

variable "hcp_boundary_project_description" {
  default     = "Contains develop resources for SafePass Sentinel project"
  description = "The description of Bondary project"
  type        = string
}

variable "boundary_vault_namespace" {
  default     = "admin"
  description = "The name of Vault namespace"
  type        = string
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