locals {
  boundary_cluster_url    = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_url
  boundary_username       = data.hcp_vault_secrets_secret.boundary_username.secret_value
  boundary_password       = data.hcp_vault_secrets_secret.boundary_password.secret_value
  boundary_hcp_cluster_id = data.terraform_remote_state.hcp_cloud.outputs.hcp_boundary_cluster_id

  public_key_openssh = data.hcp_vault_secrets_secret.public_key_openssh.secret_value

  ami = data.aws_ami.ubuntu.id

  egress_worker_sg_id     = data.terraform_remote_state.network.outputs.security_group_ids["egress-worker"]
  egress_worker_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]
}
