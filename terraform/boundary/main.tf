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
  address   = local.vault_private_endpoint_url
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

####################################################################################################
### Admin user
####################################################################################################
resource "boundary_auth_method" "password" {
  scope_id = boundary_scope.org.id
  type     = "password"
}

resource "boundary_account_password" "admin" {
  auth_method_id = boundary_auth_method.password.id
  name           = "Pogosoftware Admins"
  login_name     = "admin"
  password       = "$uper$ecure"
}

resource "boundary_user" "admin" {
  name        = "admin"
  account_ids = [boundary_account_password.admin.id]
  scope_id    = boundary_scope.org.id
}

resource "boundary_group" "admin" {
  name       = "Pogosoftware Admins"
  member_ids = [boundary_user.admin.id]
  scope_id   = boundary_scope.org.id
}

resource "boundary_role" "admin" {
  name          = "Project admins"
  principal_ids = [boundary_group.admin.id]
  grant_strings = ["ids=*;type=*;actions=*"]
  scope_id      = boundary_scope.project.id
}

####################################################################################################
### AWS DYNAMIC HOSTS
####################################################################################################
resource "aws_iam_user" "boundary" {
  name = "boundary"
  path = "/"
}

resource "aws_iam_access_key" "boundary" {
  user = aws_iam_user.boundary.name
}

resource "aws_iam_user_policy" "boundary_describe_instances" {
  name   = "BoundaryDescribeInstances"
  user   = aws_iam_user.boundary.name
  policy = data.aws_iam_policy_document.boudary_describe_instances.json
}

resource "boundary_host_catalog_plugin" "egress_workers" {
  name            = "boundary egress workers"
  scope_id        = boundary_scope.project.id
  plugin_name     = "aws"
  attributes_json = jsonencode({ "region" = var.aws_region })

  secrets_json = jsonencode({
    "access_key_id"     = aws_iam_access_key.boundary.id
    "secret_access_key" = aws_iam_access_key.boundary.secret
  })
}

resource "boundary_host_set_plugin" "egress_workers" {
  name            = "boudary egress workers"
  host_catalog_id = boundary_host_catalog_plugin.egress_workers.id
  attributes_json = jsonencode({ "filters" = ["tag:InstanceGroup=EC2_Egress_Workers"] })
}

resource "boundary_host_catalog_plugin" "postgres" {
  name            = "postgres databases"
  scope_id        = boundary_scope.project.id
  plugin_name     = "aws"
  attributes_json = jsonencode({ "region" = var.aws_region })

  secrets_json = jsonencode({
    "access_key_id"     = aws_iam_access_key.boundary.id
    "secret_access_key" = aws_iam_access_key.boundary.secret
  })
}

resource "boundary_host_set_plugin" "postgres" {
  name            = "postgres databases"
  host_catalog_id = boundary_host_catalog_plugin.egress_workers.id
  attributes_json = jsonencode({ "filters" = ["tag:InstanceGroup=RDS_Postgres"] })
}
