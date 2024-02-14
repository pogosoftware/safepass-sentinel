provider "hcp" {
  project_id = var.hcp_project_id
}

provider "vault" {
  address = local.vault_public_endpoint_url
}