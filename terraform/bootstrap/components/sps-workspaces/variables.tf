####################################################################################################
### GLOBAL
####################################################################################################
variable "environment" {
  default     = "dev"
  description = "The name of environment. Allwed values: `dev`, `stg`, `prd`. Defaults to `dev`"
  type        = string
}

variable "hcp_client_id" {
  description = "The ID of HCP client"
  type        = string
}

variable "hcp_client_secret" {
  description = "The secret of HCP client"
  type        = string
}

variable "tfe_token" {
  description = "The token to HCP Cloud"
  type        = string
}

variable "hcp_project_id" {
  description = "The ID to HCP project"
  type        = string
}

####################################################################################################
### TFC
####################################################################################################
variable "tfe_project_name" {
  default     = "SafePass_Sentinel"
  description = "The name of the TFC project"
}

variable "vcs_repo" {
  default = {
    identifier = "pogosoftware/safepass-sentinel"
    branch     = "feature/bootstrap"
  }
  description = "The repository where modules are"
  type = object({
    identifier = string
    branch     = string
  })
}

variable "allow_destroy_plan" {
  default     = true
  description = "Determinate to allow query plan or not"
  type        = bool
}

variable "auto_apply" {
  default     = true
  description = "Determinate to auto apply changes or not"
  type        = bool
}

####################################################################################################
### AWS
####################################################################################################
variable "aws_region" {
  default     = "eu-central-1"
  description = "The name of AWS region"
  type        = string
}

variable "aws_workload_identity_audience" {
  default     = "aws.workload.identity"
  description = "Will be used as the aud claim for the identity token. Required if `tfc_aws_provider_auth` is set to `true`. Defaults to `aws.workload.identity`"
  type        = string
}