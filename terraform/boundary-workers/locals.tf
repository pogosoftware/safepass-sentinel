locals {
  ami = data.aws_ami.ubuntu.id

  ingress_worker_sg_ids    = data.terraform_remote_state.network.outputs.security_group_ids["ingress-worker"]
  ingress_worker_subnet_id = data.terraform_remote_state.network.outputs.public_subnet_ids[0]

  egress_worker_sg_ids    = data.terraform_remote_state.network.outputs.security_group_ids["egress-worker"]
  egress_worker_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]
}
