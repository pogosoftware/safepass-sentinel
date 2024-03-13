<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7.0 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.83 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0 |
| <a name="requirement_utils"></a> [utils](#requirement\_utils) | ~> 1.18 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 3.25 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | ~> 0.83 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.0 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | ~> 3.25 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [tls_private_key.vault](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [vault_kv_secret_v2.boundary](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_mount.apps](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_mount.ssh](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/mount) | resource |
| [vault_policy.boundary_controller](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_policy.ssh](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/policy) | resource |
| [vault_ssh_secret_backend_ca.ssh](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/ssh_secret_backend_ca) | resource |
| [vault_ssh_secret_backend_role.boundary_client](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/ssh_secret_backend_role) | resource |
| [vault_token.boundary](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/token) | resource |
| [hcp_organization.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/organization) | data source |
| [terraform_remote_state.bootstrap](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.hcp_cloud](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_hcp_project_id"></a> [hcp\_project\_id](#input\_hcp\_project\_id) | The UUID of HCP project | `string` | n/a | yes |
| <a name="input_vault_apps_boundary_secret_name"></a> [vault\_apps\_boundary\_secret\_name](#input\_vault\_apps\_boundary\_secret\_name) | The name of boundary secret in vault | `string` | `"infra/boundary"` | no |
| <a name="input_vault_apps_mount_name"></a> [vault\_apps\_mount\_name](#input\_vault\_apps\_mount\_name) | The name of Vault mount for apps | `string` | `"apps"` | no |
| <a name="input_vault_ssh_default_user"></a> [vault\_ssh\_default\_user](#input\_vault\_ssh\_default\_user) | The SSH default user name | `string` | `"ubuntu"` | no |
| <a name="input_vault_ssh_mount_path"></a> [vault\_ssh\_mount\_path](#input\_vault\_ssh\_mount\_path) | The path to SSH Vault mount | `string` | `"ssh-client-signer"` | no |
| <a name="input_vault_ssh_role_name"></a> [vault\_ssh\_role\_name](#input\_vault\_ssh\_role\_name) | The name of SSH backend role | `string` | `"boundary-client"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vault_apps_boundary_secret_name"></a> [vault\_apps\_boundary\_secret\_name](#output\_vault\_apps\_boundary\_secret\_name) | The name of boundary secret in vault |
| <a name="output_vault_apps_mount_name"></a> [vault\_apps\_mount\_name](#output\_vault\_apps\_mount\_name) | The name of Vault mount for apps |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
