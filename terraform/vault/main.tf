####################################################################################################
### VAULT SSH RESOURCES
####################################################################################################
resource "tls_private_key" "vault" {
  algorithm = "ED25519"
}

resource "vault_namespace" "this" {
  path = var.vault_namespace
}

resource "vault_mount" "ssh" {
  namespace = vault_namespace.this.namespace
  path      = var.vault_ssh_mount_path
  type      = "ssh"
}

resource "vault_ssh_secret_backend_ca" "ssh" {
  namespace            = vault_namespace.this.namespace
  backend              = vault_mount.ssh.path
  generate_signing_key = false
  public_key           = tls_private_key.vault.public_key_openssh
  private_key          = tls_private_key.vault.private_key_openssh
}

resource "vault_policy" "boundary_controller" {
  namespace = vault_namespace.this.namespace
  name      = "boundary-controller"

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
  namespace = vault_namespace.this.namespace
  name      = "ssh"

  policy = <<EOT
path "${var.vault_ssh_mount_path}/issue/${var.vault_ssh_role_name}" {
  capabilities = ["create", "update"]
}

path "${var.vault_ssh_mount_path}/sign/${var.vault_ssh_role_name}" {
  capabilities = ["create", "update"]
}
EOT
}

resource "vault_ssh_secret_backend_role" "boundary_client" {
  namespace               = vault_namespace.this.namespace
  name                    = var.vault_ssh_role_name
  backend                 = vault_mount.ssh.path
  key_type                = "ca"
  allow_user_certificates = true
  default_user            = var.vault_ssh_default_user
  default_extensions = {
    "permit-pty" : ""
  }
  allowed_users      = "*"
  allowed_extensions = "*"
}

resource "vault_token" "boundary" {
  namespace         = vault_namespace.this.namespace
  no_default_policy = true
  policies          = ["boundary-controller", "ssh"]
  no_parent         = true
  period            = "24h"
  renewable         = true
}

####################################################################################################
### HCP VAULT SECRETS
####################################################################################################
resource "hcp_vault_secrets_app" "vault" {
  app_name    = "vault"
  description = "This app contains credentials to VAULT"
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

resource "hcp_vault_secrets_secret" "vault_boundary_client_token" {
  app_name     = hcp_vault_secrets_app.vault.app_name
  secret_name  = "vault_boundary_client_token"
  secret_value = vault_token.boundary.client_token
}