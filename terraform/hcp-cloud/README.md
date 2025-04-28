<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.78.0 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.100.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.61.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vault_credentials_variable_set"></a> [vault\_credentials\_variable\_set](#module\_vault\_credentials\_variable\_set) | pogosoftware/tfe/tfe//modules/variable-set | 4.0.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_boundary_cluster_id"></a> [boundary\_cluster\_id](#input\_boundary\_cluster\_id) | The ID of the Boundary cluster | `string` | `"safepass-sentinel"` | no |
| <a name="input_boundary_tier"></a> [boundary\_tier](#input\_boundary\_tier) | The tier that the HCP Boundary cluster will be provisioned as, 'Standard' or 'Plus' | `string` | `"Standard"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| <a name="input_hcp_cloud_cidr_block"></a> [hcp\_cloud\_cidr\_block](#input\_hcp\_cloud\_cidr\_block) | The CIDR of hvn network | `string` | `"172.25.16.0/20"` | no |
| <a name="input_hcp_cloud_cloud_provider"></a> [hcp\_cloud\_cloud\_provider](#input\_hcp\_cloud\_cloud\_provider) | The name of cloud provider | `string` | `"aws"` | no |
| <a name="input_hcp_cloud_hvn_id"></a> [hcp\_cloud\_hvn\_id](#input\_hcp\_cloud\_hvn\_id) | The name of hvn network | `string` | `"hvn"` | no |
| <a name="input_hcp_cloud_region"></a> [hcp\_cloud\_region](#input\_hcp\_cloud\_region) | The name of region where hvn will network be created | `string` | `"eu-central-1"` | no |
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
<!-- END_TF_DOCS -->
