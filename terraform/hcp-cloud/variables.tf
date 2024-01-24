####################################################################################################
### HCP CLOUD
####################################################################################################
variable "hcp_project_id" {
  description = "The UUID of HCP project"
  type        = string
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

variable "hcp_cloud_vault_cluster_id" {
  default     = "sefapass-sentinel-dev"
  description = "The name of Valut cluster"
  type        = string
}

variable "hcp_cloud_vault_public_endpoint" {
  default     = true
  description = "Determinates to set public endpoint or not"
  type        = bool
}

variable "hcp_cloud_vault_tier" {
  default     = "dev"
  description = "The name of Vault tier"
  type        = string
}

####################################################################################################
### HCP BOUNDARY CLUSTER
####################################################################################################
variable "boundary_username" {
  default     = "boundary-admin"
  description = "The name of Bonundary admin user"
  type        = string
}

variable "hcp_cloud_boundary_cluster_id" {
  default     = "safepass-sentinel-dev"
  description = "The ID of the Boundary cluster"
  type        = string
}

variable "hcp_cloud_boundary_tier" {
  default     = "Standard"
  description = "The tier that the HCP Boundary cluster will be provisioned as, 'Standard' or 'Plus'"
  type        = string
}
