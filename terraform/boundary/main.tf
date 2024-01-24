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
  name      = "certificates-store"
  address   = local.vault_public_endpoint_url
  token     = local.vault_client_token
  scope_id  = boundary_scope.project.id
  namespace = var.boundary_vault_namespace
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
