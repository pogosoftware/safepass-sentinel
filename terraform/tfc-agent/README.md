<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.7.0 |
| aws | ~> 5.39 |
| hcp | ~> 0.83 |
| tfe | ~> 0.52 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.39 |
| hcp | ~> 0.83 |
| terraform | n/a |
| tfe | ~> 0.52 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The Name of AWS region | `string` | `"eu-central-1"` | no |
| bootstrap\_workspace\_name | The name of bootstrap workspace | `string` | n/a | yes |
| cpu\_units | Amount of CPU units for a single ECS task | `number` | `1024` | no |
| ecs\_task\_desired\_count | How many ECS tasks should run in parallel | `number` | `1` | no |
| environment | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| hcp\_project\_id | The UUID of HCP project | `string` | n/a | yes |
| image | The Name of Terraform Cloud Agent docker image | `string` | `"hashicorp/tfc-agent:latest"` | no |
| memory | Amount of memory in MB for a single ECS task | `number` | `2048` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->
