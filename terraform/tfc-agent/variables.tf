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

variable "hcp_network_workspace_name" {
  default     = "network-euc1"
  description = "The name of network TFC workspace"
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

####################################################################################################
### ECS VARIABLES
####################################################################################################
variable "image" {
  default     = "hashicorp/tfc-agent:latest"
  description = "The Name of Terraform Cloud Agent docker image"
  type        = string
}

variable "ecs_task_desired_count" {
  default     = 1
  description = "How many ECS tasks should run in parallel"
  type        = number
}

variable "cpu_units" {
  description = "Amount of CPU units for a single ECS task"
  default     = 256
  type        = number
}

variable "memory" {
  description = "Amount of memory in MB for a single ECS task"
  default     = 512
  type        = number
}