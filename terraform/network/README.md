<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.78.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.17.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_network_enable_dns_hostnames"></a> [network\_enable\_dns\_hostnames](#input\_network\_enable\_dns\_hostnames) | Determinates to enable dns hostnames or not | `bool` | `true` | no |
| <a name="input_network_enable_dns_support"></a> [network\_enable\_dns\_support](#input\_network\_enable\_dns\_support) | Determinates to enable dns support or not | `bool` | `true` | no |
| <a name="input_network_enable_nat_gateway"></a> [network\_enable\_nat\_gateway](#input\_network\_enable\_nat\_gateway) | Determinates enable nat gateway or not | `bool` | `true` | no |
| <a name="input_network_manage_default_network_acl"></a> [network\_manage\_default\_network\_acl](#input\_network\_manage\_default\_network\_acl) | Determinate to manage default network acl or not | `bool` | `false` | no |
| <a name="input_network_manage_default_route_table"></a> [network\_manage\_default\_route\_table](#input\_network\_manage\_default\_route\_table) | Determinate to manage default network route table or not | `bool` | `false` | no |
| <a name="input_network_manage_default_security_group"></a> [network\_manage\_default\_security\_group](#input\_network\_manage\_default\_security\_group) | Determinate to manage default security group or not | `bool` | `false` | no |
| <a name="input_network_manage_default_vpc"></a> [network\_manage\_default\_vpc](#input\_network\_manage\_default\_vpc) | Determinate to manage default vpc or not | `bool` | `false` | no |
| <a name="input_network_one_nat_gateway_per_az"></a> [network\_one\_nat\_gateway\_per\_az](#input\_network\_one\_nat\_gateway\_per\_az) | Determinates to have one nat gateway per az or not | `bool` | `false` | no |
| <a name="input_network_security_groups"></a> [network\_security\_groups](#input\_network\_security\_groups) | The names of the security groups | `map(object({ description = string }))` | <pre>{<br/>  "client-vpn-endpoint": {<br/>    "description": "This is SG for AWS VPN Client"<br/>  },<br/>  "database": {<br/>    "description": "This is SG for RDS"<br/>  },<br/>  "egress-worker": {<br/>    "description": "This is SG for Boundary Egress Worker"<br/>  },<br/>  "tfc-agent": {<br/>    "description": "This is SG for ECS Cluster for TFC Agents"<br/>  }<br/>}</pre> | no |
| <a name="input_network_single_nat_gateway"></a> [network\_single\_nat\_gateway](#input\_network\_single\_nat\_gateway) | Determinates to have single nat gateway or not | `bool` | `true` | no |
| <a name="input_network_vpc_cidr"></a> [network\_vpc\_cidr](#input\_network\_vpc\_cidr) | The CIDR of vpc | `string` | `"10.0.0.0/16"` | no |
| <a name="input_network_vpc_name"></a> [network\_vpc\_name](#input\_network\_vpc\_name) | The name of vpc | `string` | `"safepass-sentinel"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | ID of database subnet group |
| <a name="output_database_subnet_group_name"></a> [database\_subnet\_group\_name](#output\_database\_subnet\_group\_name) | Name of database subnet group |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | List of IDs of private route tables |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The ID's of private subnets |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | List of IDs of public route tables |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The ID's of public subnets |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | The IDs of security groups |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR of VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of VPC |
| <a name="output_vpc_owner_id"></a> [vpc\_owner\_id](#output\_vpc\_owner\_id) | The ID of the AWS account that owns the VPC |
<!-- END_TF_DOCS -->
