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
  name      = "vault-ssh-develop-store"
  address   = local.vault_public_endpoint_url
  token     = local.vault_client_token
  scope_id  = boundary_scope.project.id
  namespace = local.vault_namespace
}

resource "boundary_credential_library_vault_ssh_certificate" "certificates_library" {
  name                = "vault-ssh-develop-library"
  credential_store_id = boundary_credential_store_vault.certificates_store.id
  path                = "ssh-client-signer/sign/boundary-client"
  username            = "ubuntu"
  key_type            = "ecdsa"
  key_bits            = 384
  extensions = {
    permit-pty = ""
  }
}

### Admin user
resource "boundary_auth_method" "password" {
  scope_id = boundary_scope.org.id
  type     = "password"
}

resource "boundary_user" "admin" {
  name     = "Admin"
  scope_id = boundary_scope.org.id
}

resource "boundary_account_password" "admin" {
  auth_method_id = boundary_auth_method.password.id
  name           = "Pogosoftware Admin"
  login_name     = "admin"
  password       = "$uper$ecure"
}

resource "boundary_group" "admin" {
  name       = "Pogosoftware Admins"
  member_ids = [boundary_user.admin.id]
  scope_id   = boundary_scope.org.id
}

resource "boundary_role" "admin" {
  name          = "Project admins"
  principal_ids = [boundary_group.admin.id]
  grant_strings = ["id=*;type=*;actions=*"]
  scope_id      = boundary_scope.project.id
}