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
### HCP CLOUD
####################################################################################################
variable "hcp_project_id" {
  description = "The UUID of HCP project"
  type        = string
}

variable "vault_variable_set_workspaces" {
  default     = ["vault-euc1", "boundary-euc1"]
  description = "The namas of workspace that will be using HCP Vault"
  type        = set(string)
}

####################################################################################################
### HCP VAULT CLUSTER
####################################################################################################
variable "hcp_cloud_hvn_id" {
  default     = "hvn"
  description = "The name of hvn network"
  type        = string
}

variable "hcp_cloud_cloud_provider" {
  default     = "aws"
  description = "The name of cloud provider"
  type        = string
}

variable "hcp_cloud_region" {
  default     = "eu-central-1"
  description = "The name of region where hvn will network be created"
  type        = string
}

variable "hcp_cloud_cidr_block" {
  default     = "172.25.16.0/20"
  description = "The CIDR of hvn network"
  type        = string
}

variable "vault_cluster_id" {
  default     = "sefapass-sentinel"
  description = "The name of Valut cluster"
  type        = string
}

variable "vault_public_endpoint" {
  default     = false
  description = "Determinates to set public endpoint or not"
  type        = bool
}

variable "vault_tier" {
  default     = "dev"
  description = "The name of Vault tier"
  type        = string
}

####################################################################################################
### HCP BOUNDARY CLUSTER
####################################################################################################
variable "boundary_cluster_id" {
  default     = "safepass-sentinel"
  description = "The ID of the Boundary cluster"
  type        = string
}

variable "boundary_tier" {
  default     = "Standard"
  description = "The tier that the HCP Boundary cluster will be provisioned as, 'Standard' or 'Plus'"
  type        = string
}

####################################################################################################
### HCP -> AWS PEERING
####################################################################################################
variable "aws_region" {
  default     = "eu-central-1"
  description = "The Name of AWS region"
  type        = string
}

variable "peering_id" {
  default     = "safepass-sentinel"
  description = "The ID of the network peering"
  type        = string
}

variable "route_id" {
  default     = "safepass-sentinel"
  description = "The ID of the HVN route"
  type        = string
}
