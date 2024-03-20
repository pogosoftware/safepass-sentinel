<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.39 |
| <a name="requirement_boundary"></a> [boundary](#requirement\_boundary) | ~> 1.1 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.83 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 3.25 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.39 |
| <a name="provider_boundary"></a> [boundary](#provider\_boundary) | ~> 1.1 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | ~> 0.83 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | ~> 3.25 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.ec2_egress_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.ec2_egress_worker](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_security_group_rule.ec2_egress_worker_allow_all_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_egress_worker_allow_ssh_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [boundary_account_password.admin](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/account_password) | resource |
| [boundary_auth_method.password](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/auth_method) | resource |
| [boundary_credential_library_vault_ssh_certificate.ssh](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/credential_library_vault_ssh_certificate) | resource |
| [boundary_credential_store_vault.ssh](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/credential_store_vault) | resource |
| [boundary_group.admin](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/group) | resource |
| [boundary_host_catalog_plugin.ec2_egress_workers](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/host_catalog_plugin) | resource |
| [boundary_host_set_plugin.ec2_egress_workers](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/host_set_plugin) | resource |
| [boundary_role.admin](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/role) | resource |
| [boundary_scope.org](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/scope) | resource |
| [boundary_scope.project](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/scope) | resource |
| [boundary_target.ec2_egress_workers](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/target) | resource |
| [boundary_target.vault](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/target) | resource |
| [boundary_user.admin](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/user) | resource |
| [boundary_worker.ec2_egress_worker](https://registry.terraform.io/providers/hashicorp/boundary/latest/docs/resources/worker) | resource |
| [tls_private_key.ec2_egress_worker](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [hcp_organization.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/organization) | data source |
| [terraform_remote_state.bootstrap](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.hcp_cloud](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vault](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [vault_kv_secret_v2.boundary](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/kv_secret_v2) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The Name of AWS region | `string` | `"eu-central-1"` | no |
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_boundary_ec2_workers_egress_name"></a> [boundary\_ec2\_workers\_egress\_name](#input\_boundary\_ec2\_workers\_egress\_name) | The name of Boundary egress worker | `string` | `"boundary-egress-worker"` | no |
| <a name="input_boundary_ec2_workers_instance_type"></a> [boundary\_ec2\_workers\_instance\_type](#input\_boundary\_ec2\_workers\_instance\_type) | The type of Boundary worker instance | `string` | `"t2.micro"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| <a name="input_hcp_boundary_org_description"></a> [hcp\_boundary\_org\_description](#input\_hcp\_boundary\_org\_description) | The description of Boundary orgranization | `string` | `"Pogosoftware"` | no |
| <a name="input_hcp_boundary_org_name"></a> [hcp\_boundary\_org\_name](#input\_hcp\_boundary\_org\_name) | The name of Boundary organization | `string` | `"Pogosoftware"` | no |
| <a name="input_hcp_boundary_project_description"></a> [hcp\_boundary\_project\_description](#input\_hcp\_boundary\_project\_description) | The description of Boundary project | `string` | `"Contains develop resources for SafePass Sentinel project"` | no |
| <a name="input_hcp_boundary_project_name"></a> [hcp\_boundary\_project\_name](#input\_hcp\_boundary\_project\_name) | The name of Boundary project | `string` | `"SafePass Sentinel Develop"` | no |
| <a name="input_hcp_project_id"></a> [hcp\_project\_id](#input\_hcp\_project\_id) | The UUID of HCP project | `string` | n/a | yes |
| <a name="input_sync_interval_seconds"></a> [sync\_interval\_seconds](#input\_sync\_interval\_seconds) | Number of seconds between the time Boundary syncs hosts in this set | `number` | `60` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
