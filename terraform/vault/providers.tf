provider "hcp" {
  project_id = var.hcp_project_id
}

provider "vault" {
  address          = "http://localhost:8200"
  skip_child_token = true
}
