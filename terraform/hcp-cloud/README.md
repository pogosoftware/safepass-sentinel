<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.7.0 |
| aws | ~> 5.39 |
| hcp | ~> 0.83 |
| random | ~> 3.6 |
| tfe | ~> 0.52 |
| vault | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.39 |
| hcp | ~> 0.83 |
| random | ~> 3.6 |
| terraform | n/a |
| tfe | ~> 0.52 |
| vault | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The Name of AWS region | `string` | `"eu-central-1"` | no |
| bootstrap\_workspace\_name | The name of bootstrap workspace | `string` | n/a | yes |
| boundary\_cluster\_id | The ID of the Boundary cluster | `string` | `"safepass-sentinel"` | no |
| boundary\_tier | The tier that the HCP Boundary cluster will be provisioned as, 'Standard' or 'Plus' | `string` | `"Standard"` | no |
| environment | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| hcp\_cloud\_cidr\_block | The CIDR of hvn network | `string` | `"172.25.16.0/20"` | no |
| hcp\_cloud\_cloud\_provider | The name of cloud provider | `string` | `"aws"` | no |
| hcp\_cloud\_hvn\_id | The name of hvn network | `string` | `"hvn"` | no |
| hcp\_cloud\_region | The name of region where hvn will network be created | `string` | `"eu-central-1"` | no |
| hcp\_project\_id | The UUID of HCP project | `string` | n/a | yes |
| peering\_id | The ID of the network peering | `string` | `"safepass-sentinel"` | no |
| route\_id | The ID of the HVN route | `string` | `"safepass-sentinel"` | no |
| vault\_cluster\_id | The name of Valut cluster | `string` | `"sefapass-sentinel"` | no |
| vault\_public\_endpoint | Determinates to set public endpoint or not | `bool` | `false` | no |
| vault\_tier | The name of Vault tier | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| hcp\_boundary\_cluster\_id | The ID of HCP Boundary cluster |
| hcp\_boundary\_cluster\_url | The URL to HCP Boundary |
| hcp\_boundary\_password | The name of HCP Boundary |
| hcp\_boundary\_username | The name of HCP Boundary |
| hcp\_vault\_devops\_namespace\_path | The path to the devops namespace |
| hcp\_vault\_devops\_namespace\_path\_fq | The fully qualified path to the devops namespace |
| hcp\_vault\_env\_namespace\_path | The path to the environment namespace |
| hcp\_vault\_env\_namespace\_path\_fq | The fully qualified path to the environment namespace |
| hcp\_vault\_private\_endpoint\_url | The private URL to HCP Vault cluster |

<!--- END_TF_DOCS --->
