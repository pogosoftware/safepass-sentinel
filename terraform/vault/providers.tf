provider "hcp" {
  project_id = var.hcp_project_id
}

provider "vault" {
  address          = local.vault_private_endpoint_url
  skip_child_token = true
}
