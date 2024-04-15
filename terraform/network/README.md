<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.7.0 |
| aws | 5.45.0 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.45.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The name of AWS region | `string` | `"eu-central-1"` | no |
| network\_enable\_dns\_hostnames | Determinates to enable dns hostnames or not | `bool` | `true` | no |
| network\_enable\_dns\_support | Determinates to enable dns support or not | `bool` | `true` | no |
| network\_enable\_nat\_gateway | Determinates enable nat gateway or not | `bool` | `true` | no |
| network\_manage\_default\_network\_acl | Determinate to manage default network acl or not | `bool` | `false` | no |
| network\_manage\_default\_security\_group | Determinate to manage default security group or not | `bool` | `false` | no |
| network\_manage\_default\_vpc | Determinate to manage default vpc or not | `bool` | `false` | no |
| network\_one\_nat\_gateway\_per\_az | Determinates to have one nat gateway per az or not | `bool` | `false` | no |
| network\_security\_groups | The names of the security groups | `map(object({ description = string }))` | <pre>{<br>  "client-vpn-endpoint": {<br>    "description": "This is SG for AWS VPN Client"<br>  },<br>  "egress-worker": {<br>    "description": "This is SG for Boundary Egress Worker"<br>  },<br>  "tfc-agent": {<br>    "description": "This is SG for ECS Cluster for TFC Agents"<br>  }<br>}</pre> | no |
| network\_single\_nat\_gateway | Determinates to have single nat gateway or not | `bool` | `true` | no |
| network\_vpc\_azs | The name of azs | `list(string)` | <pre>[<br>  "eu-central-1a"<br>]</pre> | no |
| network\_vpc\_cidr | The CIDR of vpc | `string` | `"10.0.0.0/16"` | no |
| network\_vpc\_name | The name of vpc | `string` | `"safepass-sentinel"` | no |
| network\_vpc\_private\_subnets | The list of private subnets | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| network\_vpc\_public\_subnets | The list of public subnets | `list(string)` | <pre>[<br>  "10.0.101.0/24"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| private\_route\_table\_ids | List of IDs of private route tables |
| private\_subnet\_ids | The ID's of private subnets |
| public\_route\_table\_ids | List of IDs of public route tables |
| public\_subnet\_ids | The ID's of public subnets |
| security\_group\_ids | The IDs of security groups |
| vpc\_cidr\_block | The CIDR of VPC |
| vpc\_id | The ID of VPC |
| vpc\_owner\_id | The ID of the AWS account that owns the VPC |

<!--- END_TF_DOCS --->
