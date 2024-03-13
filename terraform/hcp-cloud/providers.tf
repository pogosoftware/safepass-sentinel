provider "aws" {
  region = var.aws_region
}

provider "hcp" {
  project_id = var.hcp_project_id
}

provider "vault" {
  address = hcp_vault_cluster.this.vault_private_endpoint_url
  token   = hcp_vault_cluster_admin_token.this.token
}
