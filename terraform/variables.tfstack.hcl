variable "aws_region" {
    description = "The name of AWS region"
    type        = string
    default     = "eu-central-1"
    sensitive   = false
    nullable    = false
}

variable "identity_token" {
  type = string
  ephemeral = true
}

variable "role_arn" {
  type = string
}

variable "default_tags" {
  type = map(string)
  default = {
    "Environment" = "develop"
  }
}