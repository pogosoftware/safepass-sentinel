<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.7.0 |
| hcp | ~> 0.83 |
| tls | ~> 4.0 |
| utils | ~> 1.18 |
| vault | ~> 3.25 |

## Providers

| Name | Version |
|------|---------|
| hcp | ~> 0.83 |
| terraform | n/a |
| tls | ~> 4.0 |
| vault | ~> 3.25 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bootstrap\_workspace\_name | The name of bootstrap workspace | `string` | n/a | yes |
| hcp\_project\_id | The UUID of HCP project | `string` | n/a | yes |
| vault\_apps\_boundary\_secret\_name | The name of boundary secret in vault | `string` | `"infra/boundary"` | no |
| vault\_apps\_mount\_name | The name of Vault mount for apps | `string` | `"apps"` | no |
| vault\_ssh\_default\_user | The SSH default user name | `string` | `"ubuntu"` | no |
| vault\_ssh\_mount\_path | The path to SSH Vault mount | `string` | `"ssh-client-signer"` | no |
| vault\_ssh\_role\_name | The name of SSH backend role | `string` | `"boundary-client"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vault\_apps\_boundary\_secret\_name | The name of boundary secret in vault |
| vault\_apps\_mount\_name | The name of Vault mount for apps |

<!--- END_TF_DOCS --->
