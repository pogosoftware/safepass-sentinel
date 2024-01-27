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

module "boundary_egress_workers" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "7.3.1"

  use_name_prefix = true
  name            = var.boundary_asg_name

  min_size          = var.boundary_asg_min_size
  max_size          = var.boundary_asg_max_size
  desired_capacity  = var.boundary_asg_desired_capacity
  health_check_type = "EC2"

  vpc_zone_identifier = [local.egress_worker_subnet_id]

  # Launch template
  launch_template_use_name_prefix = true
  launch_template_name            = var.boundary_asg_name
  launch_template_description     = "Launch template for Boundary Egress Workers"
  update_default_version          = true

  image_id      = local.ami
  instance_type = var.boundary_workers_instance_type
  ebs_optimized = true
  user_data     = base64encode(local.user_data)
  key_name      = aws_key_pair.ansible.key_name

  metadata_options = {
    http_tokens = "required"
  }

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [local.egress_worker_sg_id]
    }
  ]

  tag_specifications = [
    {
      resource_type = "instance"
      tags = {
        ProjectID     = var.hcp_project_id
        Environment   = var.environment
        InstanceGroup = "Boundary_Egress_Workers"
      }
    }
  ]

  tags = {
    ProjectID   = var.hcp_project_id
    Environment = var.environment
  }
}
