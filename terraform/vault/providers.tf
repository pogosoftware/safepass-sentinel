provider "hcp" {
  project_id = var.hcp_project_id
}

provider "vault" {
  skip_child_token = true
}
