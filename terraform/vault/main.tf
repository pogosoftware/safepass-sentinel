####################################################################################################
### SSH KEYS
####################################################################################################
resource "tls_private_key" "vault" {
  algorithm = "ED25519"
}

####################################################################################################
### VAULT SSH RESOURCES
####################################################################################################
resource "vault_mount" "ssh" {
  path = var.vault_ssh_mount_path
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

  policy = file("templates/boundary-controller-policy.hcl")
}

resource "vault_policy" "ssh" {
  name = "ssh"

  policy = templatefile("templates/ssh-policy.hcl", {
    vault_ssh_mount_path = var.vault_ssh_mount_path,
    vault_ssh_role_name  = var.vault_ssh_role_name
  })
}

resource "vault_ssh_secret_backend_role" "boundary_client" {
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
  no_default_policy = true
  policies          = ["boundary-controller", "ssh"]
  no_parent         = true
  period            = "24h"
  renewable         = true
}

####################################################################################################
### VAULT APPS
####################################################################################################
resource "vault_mount" "apps" {
  path = var.vault_apps_mount_name
  type = "kv-v2"
}

resource "vault_kv_secret_v2" "boundary" {
  mount               = vault_mount.apps.path
  name                = var.vault_apps_boundary_secret_name
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      username    = local.boundary_username,
      password    = local.boundary_password,
      vault_token = vault_token.boundary.client_token
    }
  )

  custom_metadata {
    max_versions = 5
    data = {
      tf_module = "hcp-cloud"
    }
  }
}
