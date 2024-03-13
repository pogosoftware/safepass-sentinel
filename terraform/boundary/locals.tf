locals {
  # boundary user
  boundary_user_access_key_id     = data.terraform_remote_state.bootstrap.outputs.boundary_user_access_key_id
  boundary_user_access_key_secret = data.terraform_remote_state.bootstrap.outputs.boundary_user_access_key_secret

  # boundary
  boundary_cluster_url       = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_url
  boundary_hcp_cluster_id    = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_id
  vault_private_endpoint_url = data.terraform_remote_state.hcp_cloud.outputs.hcp_vault_private_endpoint_url

  boundary_vault_mount_name  = data.terraform_remote_state.vault.outputs.vault_apps_mount_name
  boundary_vault_secret_name = data.terraform_remote_state.vault.outputs.vault_apps_boundary_secret_name

  ec2_egress_worker_sg_id     = data.terraform_remote_state.network.outputs.security_group_ids["egress-worker"]
  ec2_egress_worker_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]

  boundary_username           = data.vault_kv_secret_v2.boundary.data["username"]
  boundary_password           = data.vault_kv_secret_v2.boundary.data["password"]
  vault_client_token          = data.vault_kv_secret_v2.boundary.data["vault_token"]
  vault_ca_public_key_openssh = data.vault_kv_secret_v2.boundary.data["vault_ca_public_key_openssh"]

  vault_namespace        = "admin/dev/devops"
  ec2_workers_egress_ami = data.aws_ami.ubuntu.id
  ssh_credential_store   = format("vault-ssh-%s", var.environment)
  ssh_credential_library = format("vault-ssh-%s", var.environment)

  aws_boundary_username  = format("boundary-%s", var.environment)
  ec2_egress_worker_name = format("%s-%s", var.boundary_ec2_workers_egress_name, var.environment)
}
