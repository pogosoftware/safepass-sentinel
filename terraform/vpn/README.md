<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.7 |
| aws | 5.54.1 |
| hcp | ~> 0.83 |
| tls | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| aws | 5.54.1 |
| hcp | ~> 0.83 |
| terraform | n/a |
| tls | 4.0.5 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| hcp\_network\_workspace\_name | The name of network TFC workspace | `string` | n/a | yes |
| hcp\_project\_id | The UUID of HCP project | `string` | n/a | yes |

## Outputs

No output.

<!--- END_TF_DOCS --->
