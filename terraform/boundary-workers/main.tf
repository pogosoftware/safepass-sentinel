resource "aws_key_pair" "ansible" {
  key_name   = "ansible"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDjkJm/8rzkU0MwHUQkIUrxOJwuSDY1KwjutsOAD1kGP"
}

module "boundary_ingress_worker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name = var.boundary_workers_ingress_name

  ami                         = local.ami
  associate_public_ip_address = true
  instance_type               = var.boundary_workers_instance_type
  key_name                    = aws_key_pair.ansible.key_name
  vpc_security_group_ids      = local.ingress_worker_sg_ids
  subnet_id                   = local.ingress_worker_subnet_id
}

module "boundary_egress_worker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name = var.boundary_workers_egress_name

  ami                         = local.ami
  associate_public_ip_address = false
  instance_type               = var.boundary_workers_instance_type
  key_name                    = aws_key_pair.ansible.key_name
  vpc_security_group_ids      = local.egress_worker_sg_ids
  subnet_id                   = local.egress_worker_subnet_id
}