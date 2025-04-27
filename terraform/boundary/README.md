<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.78.0 |
| <a name="provider_boundary"></a> [boundary](#provider\_boundary) | 1.2.0 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.100.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |
| <a name="provider_vault"></a> [vault](#provider\_vault) | 4.6.0 |

## Modules

No modules.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_boundary_ec2_workers_egress_name"></a> [boundary\_ec2\_workers\_egress\_name](#input\_boundary\_ec2\_workers\_egress\_name) | The name of Boundary egress worker | `string` | `"boundary-egress-worker"` | no |
| <a name="input_boundary_ec2_workers_instance_type"></a> [boundary\_ec2\_workers\_instance\_type](#input\_boundary\_ec2\_workers\_instance\_type) | The type of Boundary worker instance | `string` | `"t2.micro"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| <a name="input_hcp_boundary_org_description"></a> [hcp\_boundary\_org\_description](#input\_hcp\_boundary\_org\_description) | The description of Boundary orgranization | `string` | `"Pogosoftware"` | no |
| <a name="input_hcp_boundary_org_name"></a> [hcp\_boundary\_org\_name](#input\_hcp\_boundary\_org\_name) | The name of Boundary organization | `string` | `"Pogosoftware"` | no |
| <a name="input_hcp_boundary_project_description"></a> [hcp\_boundary\_project\_description](#input\_hcp\_boundary\_project\_description) | The description of Boundary project | `string` | `"Contains develop resources for SafePass Sentinel project"` | no |
| <a name="input_hcp_boundary_project_name"></a> [hcp\_boundary\_project\_name](#input\_hcp\_boundary\_project\_name) | The name of Boundary project | `string` | `"SafePass Sentinel Develop"` | no |
| <a name="input_sync_interval_seconds"></a> [sync\_interval\_seconds](#input\_sync\_interval\_seconds) | Number of seconds between the time Boundary syncs hosts in this set | `number` | `60` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
