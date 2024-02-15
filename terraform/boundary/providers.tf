provider "hcp" {
  project_id = var.hcp_project_id
}

provider "boundary" {
  addr                   = local.boundary_cluster_url
  auth_method_login_name = local.boundary_username
  auth_method_password   = local.boundary_password
}

provider "aws" {
  region = var.aws_region
}
