<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.101.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.5.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
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
<!-- END_TF_DOCS -->
