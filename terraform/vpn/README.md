<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 5.32.1 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | ~> 0.83 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.32.1 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | ~> 0.83 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.client](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.server](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/acm_certificate) | resource |
| [aws_ec2_client_vpn_authorization_rule.example](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/ec2_client_vpn_authorization_rule) | resource |
| [aws_ec2_client_vpn_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/ec2_client_vpn_endpoint) | resource |
| [aws_ec2_client_vpn_network_association.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/ec2_client_vpn_network_association) | resource |
| [aws_security_group_rule.vpn_client](https://registry.terraform.io/providers/hashicorp/aws/5.32.1/docs/resources/security_group_rule) | resource |
| [hcp_vault_secrets_app.vpn](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_secrets_app) | resource |
| [hcp_vault_secrets_secret.ca_cert](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_secrets_secret) | resource |
| [hcp_vault_secrets_secret.ca_key](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_secrets_secret) | resource |
| [hcp_vault_secrets_secret.client_cert](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_secrets_secret) | resource |
| [hcp_vault_secrets_secret.client_key](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_secrets_secret) | resource |
| [hcp_vault_secrets_secret.server_cert](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_secrets_secret) | resource |
| [hcp_vault_secrets_secret.server_key](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_secrets_secret) | resource |
| [tls_cert_request.client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/cert_request) | resource |
| [tls_cert_request.server](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/cert_request) | resource |
| [tls_locally_signed_cert.client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/locally_signed_cert) | resource |
| [tls_locally_signed_cert.server](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/locally_signed_cert) | resource |
| [tls_private_key.ca](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [tls_private_key.client](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [tls_private_key.server](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/private_key) | resource |
| [tls_self_signed_cert.ca](https://registry.terraform.io/providers/hashicorp/tls/4.0.5/docs/resources/self_signed_cert) | resource |
| [hcp_organization.this](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/data-sources/organization) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hcp_network_workspace_name"></a> [hcp\_network\_workspace\_name](#input\_hcp\_network\_workspace\_name) | The name of network TFC workspace | `string` | n/a | yes |
| <a name="input_hcp_project_id"></a> [hcp\_project\_id](#input\_hcp\_project\_id) | The UUID of HCP project | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
