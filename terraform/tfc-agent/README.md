<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.78.0 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.101.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | 0.60.1 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_cpu_units"></a> [cpu\_units](#input\_cpu\_units) | Amount of CPU units for a single ECS task | `number` | `1024` | no |
| <a name="input_ecs_task_desired_count"></a> [ecs\_task\_desired\_count](#input\_ecs\_task\_desired\_count) | How many ECS tasks should run in parallel | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| <a name="input_image"></a> [image](#input\_image) | The Name of Terraform Cloud Agent docker image | `string` | `"hashicorp/tfc-agent:latest"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory in MB for a single ECS task | `number` | `2048` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
