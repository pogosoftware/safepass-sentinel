<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.39 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.83 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.52 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.39 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | ~> 0.83 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.52 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |
| [aws_ecs_service.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.tfc_agents](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.tfs_agents_inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.tfc_agents_task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group_rule.allow_22_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_443_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.allow_8200_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.agent_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [tfe_agent_pool.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/agent_pool) | resource |
| [tfe_agent_token.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/agent_token) | resource |
| [tfe_workspace_settings.agents](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings) | resource |
| [aws_iam_policy_document.task_assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.tfc_agent_inline](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [hcp_organization.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/organization) | data source |
| [terraform_remote_state.bootstrap](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The Name of AWS region | `string` | `"eu-central-1"` | no |
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_cpu_units"></a> [cpu\_units](#input\_cpu\_units) | Amount of CPU units for a single ECS task | `number` | `1024` | no |
| <a name="input_ecs_task_desired_count"></a> [ecs\_task\_desired\_count](#input\_ecs\_task\_desired\_count) | How many ECS tasks should run in parallel | `number` | `1` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| <a name="input_hcp_project_id"></a> [hcp\_project\_id](#input\_hcp\_project\_id) | The UUID of HCP project | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | The Name of Terraform Cloud Agent docker image | `string` | `"hashicorp/tfc-agent:latest"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Amount of memory in MB for a single ECS task | `number` | `2048` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
