####################################################################################################
### BOUNDARY
####################################################################################################
resource "boundary_worker" "egress_worker" {
  scope_id                    = "global"
  name                        = "bounday-egress-worker"
  worker_generated_auth_token = ""
}

resource "aws_key_pair" "ansible" {
  key_name   = "ansible"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDjkJm/8rzkU0MwHUQkIUrxOJwuSDY1KwjutsOAD1kGP"
}

resource "aws_iam_policy" "ec2_get_ssm_param" {
  name   = "ec2_get_ssm_param"
  path   = "/"
  policy = data.aws_iam_policy_document.ssm.json
}

resource "aws_security_group_rule" "egress_allow_all" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.egress_worker_sg_id
}

resource "aws_security_group_rule" "ingress_allow_ssh" {
  type              = "ingress"
  to_port           = 22
  protocol          = "tcp"
  from_port         = 22
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = local.egress_worker_sg_id
}

module "boundary_egress_worker" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.6.0"

  name = var.boundary_workers_egress_name

  ami                         = local.ami
  associate_public_ip_address = false
  instance_type               = var.boundary_workers_instance_type
  key_name                    = aws_key_pair.ansible.key_name
  vpc_security_group_ids      = [local.egress_worker_sg_id]
  subnet_id                   = local.egress_worker_subnet_id

  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = true

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 Boundary Egress Worker instance"
  iam_role_policies = {
    SSMParameter = aws_iam_policy.ec2_get_ssm_param.arn
  }

  metadata_options = {
    "http_tokens": "required"
  }
}