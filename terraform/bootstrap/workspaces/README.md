# Usage
<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~>1.7.0 |
| aws | ~> 5.39 |
| hcp | ~> 0.83 |
| tfe | ~> 0.52 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.39 |
| hcp | ~> 0.83 |
| tfe | ~> 0.52 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allow\_destroy\_plan | Determinate to allow query plan or not | `bool` | `true` | no |
| auto\_apply | Determinate to auto apply changes or not | `bool` | `true` | no |
| aws\_region | The name of AWS region | `string` | `"eu-central-1"` | no |
| aws\_workload\_identity\_audience | Will be used as the aud claim for the identity token. Required if `tfc_aws_provider_auth` is set to `true`. Defaults to `aws.workload.identity` | `string` | `"aws.workload.identity"` | no |
| environment | The name of environment. Allowed values: `dev`, `stg`, `prd`. Defaults to `dev` | `string` | `"dev"` | no |
| hcp\_client\_id | The ID of HCP client | `string` | n/a | yes |
| hcp\_client\_secret | The secret of HCP client | `string` | n/a | yes |
| hcp\_project\_id | The ID to HCP project | `string` | n/a | yes |
| name\_prefix | The prefix of names. Defaults to `sps` | `string` | `"sps"` | no |
| tfe\_project\_name | The name of the TFC project | `string` | `"SafePass_Sentinel"` | no |
| tfe\_token | The token to HCP Cloud | `string` | n/a | yes |
| vcs\_repo | The repository where modules are | <pre>object({<br>    identifier = string<br>    branch     = string<br>  })</pre> | <pre>{<br>  "branch": "feature/bootstrap",<br>  "identifier": "pogosoftware/safepass-sentinel"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| boundary\_user\_access\_key\_id | The access key ID |
| boundary\_user\_access\_key\_secret | The access key secret |
| workspaces | The id and name of existing TFC workspaces |

<!--- END_TF_DOCS --->
