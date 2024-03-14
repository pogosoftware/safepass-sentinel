<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.39 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.83 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.52 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 3.25 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.39 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | ~> 0.83 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.6 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.52 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | ~> 3.25 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vault_credentials_variable_set"></a> [vault\_credentials\_variable\_set](#module\_vault\_credentials\_variable\_set) | pogosoftware/tfe/tfe//modules/variable-set | 1.3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_route.private_to_hvn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_vpc_peering_connection_accepter.peer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_peering_connection_accepter) | resource |
| [hcp_aws_network_peering.peer](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/aws_network_peering) | resource |
| [hcp_boundary_cluster.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/boundary_cluster) | resource |
| [hcp_hvn.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn) | resource |
| [hcp_hvn_route.peer_route](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn_route) | resource |
| [hcp_vault_cluster.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster) | resource |
| [hcp_vault_cluster_admin_token.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster_admin_token) | resource |
| [random_password.boundary_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.boundary_username](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [tfe_variable.tfe_vault_run_role_workspace_variable](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [vault_jwt_auth_backend.jwt](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.workspaces](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |
| [vault_namespace.devops](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/namespace) | resource |
| [vault_namespace.env](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/namespace) | resource |
| [vault_policy.workspaces](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [hcp_organization.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/organization) | data source |
| [hcp_project.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/project) | data source |
| [terraform_remote_state.bootstrap](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The Name of AWS region | `string` | `"eu-central-1"` | no |
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_boundary_cluster_id"></a> [boundary\_cluster\_id](#input\_boundary\_cluster\_id) | The ID of the Boundary cluster | `string` | `"safepass-sentinel"` | no |
| <a name="input_boundary_tier"></a> [boundary\_tier](#input\_boundary\_tier) | The tier that the HCP Boundary cluster will be provisioned as, 'Standard' or 'Plus' | `string` | `"Standard"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| <a name="input_hcp_cloud_cidr_block"></a> [hcp\_cloud\_cidr\_block](#input\_hcp\_cloud\_cidr\_block) | The CIDR of hvn network | `string` | `"172.25.16.0/20"` | no |
| <a name="input_hcp_cloud_cloud_provider"></a> [hcp\_cloud\_cloud\_provider](#input\_hcp\_cloud\_cloud\_provider) | The name of cloud provider | `string` | `"aws"` | no |
| <a name="input_hcp_cloud_hvn_id"></a> [hcp\_cloud\_hvn\_id](#input\_hcp\_cloud\_hvn\_id) | The name of hvn network | `string` | `"hvn"` | no |
| <a name="input_hcp_cloud_region"></a> [hcp\_cloud\_region](#input\_hcp\_cloud\_region) | The name of region where hvn will network be created | `string` | `"eu-central-1"` | no |
| <a name="input_hcp_project_id"></a> [hcp\_project\_id](#input\_hcp\_project\_id) | The UUID of HCP project | `string` | n/a | yes |
| <a name="input_peering_id"></a> [peering\_id](#input\_peering\_id) | The ID of the network peering | `string` | `"safepass-sentinel"` | no |
| <a name="input_route_id"></a> [route\_id](#input\_route\_id) | The ID of the HVN route | `string` | `"safepass-sentinel"` | no |
| <a name="input_vault_cluster_id"></a> [vault\_cluster\_id](#input\_vault\_cluster\_id) | The name of Valut cluster | `string` | `"sefapass-sentinel"` | no |
| <a name="input_vault_public_endpoint"></a> [vault\_public\_endpoint](#input\_vault\_public\_endpoint) | Determinates to set public endpoint or not | `bool` | `false` | no |
| <a name="input_vault_tier"></a> [vault\_tier](#input\_vault\_tier) | The name of Vault tier | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hcp_boundary_cluster_id"></a> [hcp\_boundary\_cluster\_id](#output\_hcp\_boundary\_cluster\_id) | The ID of HCP Boundary cluster |
| <a name="output_hcp_boundary_cluster_url"></a> [hcp\_boundary\_cluster\_url](#output\_hcp\_boundary\_cluster\_url) | The URL to HCP Boundary |
| <a name="output_hcp_boundary_password"></a> [hcp\_boundary\_password](#output\_hcp\_boundary\_password) | The name of HCP Boundary |
| <a name="output_hcp_boundary_username"></a> [hcp\_boundary\_username](#output\_hcp\_boundary\_username) | The name of HCP Boundary |
| <a name="output_hcp_vault_devops_namespace_path"></a> [hcp\_vault\_devops\_namespace\_path](#output\_hcp\_vault\_devops\_namespace\_path) | The path to the devops namespace |
| <a name="output_hcp_vault_devops_namespace_path_fq"></a> [hcp\_vault\_devops\_namespace\_path\_fq](#output\_hcp\_vault\_devops\_namespace\_path\_fq) | The fully qualified path to the devops namespace |
| <a name="output_hcp_vault_env_namespace_path"></a> [hcp\_vault\_env\_namespace\_path](#output\_hcp\_vault\_env\_namespace\_path) | The path to the environment namespace |
| <a name="output_hcp_vault_env_namespace_path_fq"></a> [hcp\_vault\_env\_namespace\_path\_fq](#output\_hcp\_vault\_env\_namespace\_path\_fq) | The fully qualified path to the environment namespace |
| <a name="output_hcp_vault_private_endpoint_url"></a> [hcp\_vault\_private\_endpoint\_url](#output\_hcp\_vault\_private\_endpoint\_url) | The private URL to HCP Vault cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
