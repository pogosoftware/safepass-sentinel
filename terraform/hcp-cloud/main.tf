# ####################################################################################################
# ### HCP VAULT CLUSTER
# ####################################################################################################
resource "hcp_hvn" "this" {
  hvn_id         = var.hcp_cloud_hvn_id
  cloud_provider = var.hcp_cloud_cloud_provider
  region         = var.hcp_cloud_region
  cidr_block     = var.hcp_cloud_cidr_block
}

resource "hcp_vault_cluster" "this" {
  cluster_id      = var.hcp_cloud_vault_cluster_id
  hvn_id          = hcp_hvn.this.hvn_id
  public_endpoint = var.hcp_cloud_vault_public_endpoint
  tier            = var.hcp_cloud_vault_tier
}

resource "hcp_vault_cluster_admin_token" "this" {
  cluster_id = hcp_vault_cluster.this.id
}

####################################################################################################
### HCP VAULT SSH RESOURCES
####################################################################################################
resource "tls_private_key" "vault" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "vault_mount" "ssh" {
  path = "ssh-client-signer"
  type = "ssh"
}

resource "vault_ssh_secret_backend_ca" "ssh" {
  backend              = vault_mount.ssh.path
  generate_signing_key = false
  public_key           = tls_private_key.vault.public_key_openssh
  private_key          = tls_private_key.vault.private_key_openssh
}

resource "vault_policy" "boundary_controller" {
  name = "boundary-controller"

  policy = <<EOT
path "auth/token/lookup-self" {
  capabilities = ["read"]
}
path "auth/token/renew-self" {
  capabilities = ["update"]
}
path "auth/token/revoke-self" {
  capabilities = ["update"]
}
path "sys/leases/renew" {
  capabilities = ["update"]
}
path "sys/leases/revoke" {
  capabilities = ["update"]
}
path "sys/capabilities-self" {
  capabilities = ["update"]
}
EOT
}

resource "vault_policy" "ssh" {
  name = "ssh"

  policy = <<EOT
path "ssh-client-signer/issue/boundary-client" {
  capabilities = ["create", "update"]
}

path "ssh-client-signer/sign/boundary-client" {
  capabilities = ["create", "update"]
}
EOT
}

resource "vault_ssh_secret_backend_role" "boundary_client" {
  name                    = "boundary-client"
  backend                 = vault_mount.ssh.path
  key_type                = "ca"
  allow_user_certificates = true
  default_user            = "ubuntu"
  default_extensions = {
    "permit-pty" : ""
  }
  allowed_users      = "*"
  allowed_extensions = "*"
}

resource "vault_token" "boundary" {
  no_default_policy = true
  policies          = ["boundary-client", "ssh"]

  no_parent = true
  period    = "24h"
  renewable = true
}

####################################################################################################
### HCP VAULT SECRETS
####################################################################################################
resource "random_string" "boundary_password" {
  length           = 32
  special          = true
  override_special = "/@£$"
}

resource "hcp_vault_secrets_app" "boundary" {
  app_name    = "boundary"
  description = "This app contains credentials to HCP Boundary"
}

resource "hcp_vault_secrets_secret" "boundary_username" {
  app_name     = hcp_vault_secrets_app.boundary.app_name
  secret_name  = "username"
  secret_value = var.boundary_username
}

resource "hcp_vault_secrets_secret" "boundary_password" {
  app_name     = hcp_vault_secrets_app.boundary.app_name
  secret_name  = "password"
  secret_value = random_string.boundary_password.result
}

resource "hcp_vault_secrets_app" "vault" {
  app_name    = "vault"
  description = "This app contains credentials to HCP VAULT"
}

resource "hcp_vault_secrets_secret" "vault_cluster_admin_token" {
  app_name     = hcp_vault_secrets_app.vault.app_name
  secret_name  = "cluster_admin_token"
  secret_value = hcp_vault_cluster_admin_token.this.token
}

resource "hcp_vault_secrets_secret" "vault_public_key_openssh" {
  app_name     = hcp_vault_secrets_app.vault.app_name
  secret_name  = "public_key_openssh"
  secret_value = tls_private_key.vault.public_key_openssh
}

resource "hcp_vault_secrets_secret" "vault_private_key_openssh" {
  app_name     = hcp_vault_secrets_app.vault.app_name
  secret_name  = "private_key_openssh"
  secret_value = tls_private_key.vault.private_key_openssh
}

####################################################################################################
### HCP BOUNDARY CLUSTER
####################################################################################################
resource "hcp_boundary_cluster" "this" {
  cluster_id = var.hcp_cloud_boundary_cluster_id
  username   = var.boundary_username
  password   = random_string.boundary_password.result
  tier       = var.hcp_cloud_boundary_tier
}

####################################################################################################
### HCP BOUNDARY RESOURCES
####################################################################################################
resource "boundary_scope" "org" {
  name                     = var.hcp_boundary_org_name
  description              = var.hcp_boundary_org_description
  scope_id                 = "global"
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_scope" "project" {
  name        = var.hcp_boundary_project_name
  description = var.hcp_boundary_project_description

  scope_id                 = boundary_scope.org.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}

resource "boundary_credential_store_vault" "certificates_store" {
  name     = "certificates-store"
  address  = hcp_vault_cluster.this.vault_public_endpoint_url
  token    = vault_token.boundary.client_token
  scope_id = boundary_scope.project.id
}

resource "boundary_credential_library_vault_ssh_certificate" "certificates_library" {
  name                = "certificates-library"
  credential_store_id = boundary_credential_store_vault.certificates_store.id
  path                = "ssh-client-signer/sign/boundary-client"
  username            = "ubuntu"
  key_type            = "ecdsa"
  key_bits            = 384
  extensions = {
    permit-pty = ""
  }
}
