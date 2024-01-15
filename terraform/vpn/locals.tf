locals {
  vpc_id              = data.terraform_remote_state.network.outputs.vpc_id
  target_network_cidr = data.terraform_remote_state.network.outputs.vpc_cidr_block
  private_subnet_id   = data.terraform_remote_state.network.outputs.private_subnet_ids[0]

  client_vpn_endpoint_sg_id = data.terraform_remote_state.network.outputs.security_group_ids["client-vpn-endpoint"]
}
