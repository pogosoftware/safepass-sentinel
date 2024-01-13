locals {
  ami = data.aws_ami.ubuntu.id

  egress_worker_sg_ids    = [data.terraform_remote_state.network.outputs.security_group_ids["egress-worker"]]
  egress_worker_subnet_id = data.terraform_remote_state.network.outputs.private_subnet_ids[0]
}
