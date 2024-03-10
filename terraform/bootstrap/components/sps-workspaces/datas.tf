data "hcp_organization" "this" {}
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "tfe_project" "this" {
  name         = local.tfe_project_name
  organization = data.hcp_organization.this.name
}

####################################################################################################
### AWS POLICIES
####################################################################################################
data "aws_iam_policy_document" "boudary_describe_instances" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInstances"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:GetUser",
      "iam:CreateAccessKey",
      "iam:DeleteAccessKey"
    ]
    resources = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/boundary"]
  }
}

data "aws_iam_policy_document" "network_plan" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeVpcAttribute"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:vpc/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeVpcs",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeAddresses",
      "ec2:DescribeNatGateways"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "network_apply" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateVpc",
      "ec2:CreateTags",
      "ec2:DeleteVpc",
      "ec2:ModifyVpcAttribute",
      "ec2:DescribeVpcAttribute",
      "ec2:CreateSubnet",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateInternetGateway",
      "ec2:CreateTags",
      "ec2:AttachInternetGateway",
      "ec2:DeleteInternetGateway",
      "ec2:DetachInternetGateway",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:AllocateAddress",
      "ec2:AssociateRouteTable",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:CreateRoute",
      "ec2:ReleaseAddress",
      "ec2:CreateNatGateway",
      "ec2:DeleteNatGateway",
      "ec2:DisassociateRouteTable",
      "ec2:DeleteRoute",
      "ec2:DeleteRouteTable"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:vpc/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:route-table/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:internet-gateway/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:elastic-ip/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:natgateway/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DisassociateAddress"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeVpcs",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeSubnets",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeAddresses",
      "ec2:DescribeNatGateways"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "hcp_cloud_plan" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeRouteTables"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "hcp_cloud_apply" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeRouteTables"
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:AcceptVpcPeeringConnection",
      "ec2:CreateTags"
    ]
    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:vpc-peering-connection/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:vpc/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:CreateRoute",
      "ec2:DeleteRoute"
    ]
    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:route-table/*"
    ]
  }
}

data "aws_iam_policy_document" "boundary_plan" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeImages",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSecurityGroupRules",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeInstanceCreditSpecifications"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeInstanceAttribute"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*"
    ]
  }
}

data "aws_iam_policy_document" "boundary_apply" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeKeyPairs",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceTypes",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DescribeInstanceCreditSpecifications"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:ImportKeyPair",
      "ec2:DeleteKeyPair",
      "ec2:RunInstances",
      "ec2:DescribeInstances"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key-pair/ec2_egress_worker"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:RunInstances",
      "ec2:CreateTags",
      "ec2:TerminateInstances",
      "ec2:DescribeInstanceAttribute",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:RevokeSecurityGroupEgress"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:instance/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:network-interface/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:subnet/*",
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/*"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ec2:RunInstances"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}::image/*"
    ]
  }
}

data "aws_iam_policy_document" "tfc_agent_plan" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:ListTagsForResource"
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/secret/terraform/agent-token-dev",
    ]

  }
  statement {
    effect = "Allow"
    actions = [
      "iam:GetRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:GetRolePolicy"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/safepass_sentinel_ecs_dev",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tfc_agent_ecs_dev"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecs:DescribeClusters",
      "ecs:DescribeServices"
    ]

    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/safepass_sentinel_dev",
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:service/safepass_sentinel_dev/tfc_agent_dev"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ssm:DescribeParameters",
      "ecs:DescribeTaskDefinition",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSecurityGroupRules"
    ]

    resources = [
      "*",
    ]
  }
}

data "aws_iam_policy_document" "tfc_agent_apply" {
  statement {
    effect = "Allow"
    actions = [
      "ssm:PutParameter",
      "ssm:GetParameter",
      "ssm:GetParameters",
      "ssm:DeleteParameter",
      "ssm:ListTagsForResource"
    ]

    resources = [
      "arn:aws:ssm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:parameter/secret/terraform/agent-token-dev",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:GetRole",
      "iam:ListInstanceProfilesForRole",
      "iam:DeleteRole",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies",
      "iam:PutRolePolicy",
      "iam:AttachRolePolicy",
      "ecs:TagResource",
      "iam:GetRolePolicy",
      "iam:DeleteRolePolicy",
      "iam:PassRole",
      "iam:DetachRolePolicy"
    ]

    resources = [
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/safepass_sentinel_ecs_dev",
      "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/tfc_agent_ecs_dev"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:RegisterTaskDefinition",
      "ecs:TagResource",
      "ecs:DescribeClusters",
      "ecs:DeleteCluster",
      "ecs:TagResource",
      "ecs:CreateService",
      "ecs:DescribeServices",
      "ecs:UpdateService",
      "ecs:DeleteService"
    ]

    resources = [
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:cluster/safepass_sentinel_dev",
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task-definition/tfc_agent_dev",
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:task-definition/tfc_agent_dev:*",
      "arn:aws:ecs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:service/safepass_sentinel_dev/tfc_agent_dev"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupEgress"
    ]

    resources = [
      "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:security-group/*",
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecs:CreateCluster",
      "ssm:DescribeParameters",
      "ecs:DescribeTaskDefinition",
      "ecs:DeregisterTaskDefinition",
      "ec2:DescribeSecurityGroups"
    ]

    resources = [
      "*",
    ]
  }
}

# data "aws_iam_policy_document" "vpn_plan" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:ListAllMyBuckets"
#     ]

#     resources = [
#       "arn:aws:s3:::*",
#     ]
#   }
# }

# data "aws_iam_policy_document" "vpn_apply" {
#   statement {
#     effect = "Allow"
#     actions = [
#       "s3:ListAllMyBuckets"
#     ]

#     resources = [
#       "arn:aws:s3:::*",
#     ]
#   }
# }


