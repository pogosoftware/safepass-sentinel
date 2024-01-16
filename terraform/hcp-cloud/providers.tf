provider "hcp" {
  project_id = var.hcp_project_id
}

provider "boundary" {
  addr                   = hcp_boundary_cluster.this.cluster_url
  auth_method_login_name = var.boundary_username
  auth_method_password   = random_string.boundary_password.result
}