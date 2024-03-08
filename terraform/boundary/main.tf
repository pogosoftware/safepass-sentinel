####################################################################################################
### BOUNDARY WORKER
####################################################################################################
resource "boundary_worker" "ec2_egress_worker" {
  scope_id                    = "global"
  name                        = local.ec2_egress_worker_name
  worker_generated_auth_token = ""
}

resource "tls_private_key" "ec2_egress_worker" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "ec2_egress_worker" {
  key_name   = "ec2_egress_worker"
  public_key = tls_private_key.ec2_egress_worker.public_key_openssh
}

resource "aws_security_group_rule" "ec2_egress_worker_allow_all_egress" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.ec2_egress_worker_sg_id
}

resource "aws_security_group_rule" "ec2_egress_worker_allow_ssh_ingress" {
  type              = "ingress"
  to_port           = 22
  protocol          = "tcp"
  from_port         = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.ec2_egress_worker_sg_id
}

resource "aws_instance" "ec2_egress_worker" {
  ami                         = local.ec2_workers_egress_ami
  associate_public_ip_address = true
  instance_type               = var.boundary_ec2_workers_instance_type
  key_name                    = aws_key_pair.ec2_egress_worker.key_name
  vpc_security_group_ids      = [local.ec2_egress_worker_sg_id]
  subnet_id                   = local.ec2_egress_worker_subnet_id

  user_data_base64 = base64encode(templatefile("${path.module}/templates/userdata.tftpl", {
    boundary_hcp_cluster_id               = local.boundary_hcp_cluster_id,
    vault_ca_public_key_openssh           = local.vault_ca_public_key_openssh,
    controller_generated_activation_token = boundary_worker.ec2_egress_worker.controller_generated_activation_token
  }))
  user_data_replace_on_change = true

  metadata_options {
    http_tokens = "required"
  }

  tags = {
    Name          = local.ec2_egress_worker_name
    ProjectID     = var.hcp_project_id
    Environment   = var.environment
    InstanceGroup = "EC2_Egress_Workers"
  }

  # provisioner "remote-exec" {
  #   connection {
  #     type        = "ssh"
  #     host        = self.private_ip
  #     user        = "ubuntu"
  #     private_key = tls_private_key.ec2_egress_worker.private_key_openssh
  #   }

  #   inline = ["cloud-init status --wait"]
  # }
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

resource "boundary_credential_store_vault" "ssh" {
  depends_on = [aws_instance.ec2_egress_worker]

  name          = local.ssh_credential_store
  address       = local.vault_public_endpoint_url
  token         = local.vault_client_token
  scope_id      = boundary_scope.project.id
  namespace     = local.vault_namespace
  worker_filter = "\"EC2_Egress_Workers\" in \"/tags/InstanceGroup\""
}

resource "boundary_credential_library_vault_ssh_certificate" "ssh" {
  name                = local.ssh_credential_library
  credential_store_id = boundary_credential_store_vault.ssh.id
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
resource "boundary_host_catalog_plugin" "ec2_egress_workers" {
  name            = "boundary egress workers"
  scope_id        = boundary_scope.project.id
  plugin_name     = "aws"
  attributes_json = jsonencode({ "region" = var.aws_region })

  secrets_json = jsonencode({
    access_key_id               = local.boundary_user_access_key_id
    secret_access_key           = base64decode(local.boundary_user_secret_access_key)
    disable_credential_rotation = true
  })
}

resource "boundary_host_set_plugin" "ec2_egress_workers" {
  name            = "boudary egress workers"
  host_catalog_id = boundary_host_catalog_plugin.ec2_egress_workers.id
  attributes_json = jsonencode({ "filters" = ["tag:InstanceGroup=EC2_Egress_Workers"] })
}

# resource "boundary_host_catalog_plugin" "postgres" {
#   name            = "postgres databases"
#   scope_id        = boundary_scope.project.id
#   plugin_name     = "aws"
#   attributes_json = jsonencode({ "region" = var.aws_region })

#   secrets_json = jsonencode({
#     "access_key_id"     = aws_iam_access_key.boundary.id
#     "secret_access_key" = aws_iam_access_key.boundary.secret
#   })
# }

# resource "boundary_host_set_plugin" "postgres" {
#   name            = "postgres databases"
#   host_catalog_id = boundary_host_catalog_plugin.egress_workers.id
#   attributes_json = jsonencode({ "filters" = ["tag:InstanceGroup=RDS_Postgres"] })
# }
