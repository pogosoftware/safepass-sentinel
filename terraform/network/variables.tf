variable "aws_region" {
  default     = "eu-central-1"
  description = "The Name of AWS region"
  type        = string
}

variable "network_vpc_name" {
  default     = "safepass-sentinel"
  description = "The name of vpc"
  type        = string
}

variable "network_vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "The CIDR of vpc"
  type        = string
}

variable "network_vpc_azs" {
  default     = ["eu-central-1a"]
  description = "The name of azs"
  type        = list(string)
}

variable "network_vpc_private_subnets" {
  default     = ["10.0.1.0/24"]
  description = "The list of private subnets"
  type        = list(string)
}

variable "network_vpc_public_subnets" {
  default     = ["10.0.101.0/24"]
  description = "The list of public subnets"
  type        = list(string)
}

variable "network_enable_nat_gateway" {
  default     = true
  description = "Determinates enable nat gateway or not"
  type        = bool
}

variable "network_single_nat_gateway" {
  default     = true
  description = "Determinates to have single nat gateway or not"
  type        = bool
}

variable "network_one_nat_gateway_per_az" {
  default     = false
  description = "Determinates to have one nat gateway per az or not"
  type        = bool
}

variable "network_enable_dns_hostnames" {
  default     = true
  description = "Determinates to enable dns hostnames or not"
  type        = bool
}

variable "network_enable_dns_support" {
  default     = true
  description = "Determinates to enable dns support or not"
  type        = bool
}

variable "network_manage_default_vpc" {
  default     = false
  description = "Determinate to manage default vpc or not"
  type        = bool
}

variable "network_manage_default_security_group" {
  default     = false
  description = "Determinate to manage default security group or not"
  type        = bool
}

variable "network_manage_default_network_acl" {
  default     = false
  description = "Determinate to manage default network acl or not"
  type        = bool
}

variable "network_security_groups" {
  default = {
    "egress-worker" = {
      description = "This is SG for Boundary Egress Worker"
    },
    "client-vpn-endpoint" = {
      description = "This is SG for AWS VPN Client"
    },
    "tfc-agent" = {
      description = "This is SG for ECS Cluster for TFC Agents"
    }
  }
  description = "The names of the security groups"
  type        = map(object({ description = string }))
}
