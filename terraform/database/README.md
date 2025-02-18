<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.81.0 |
| <a name="provider_hcp"></a> [hcp](#provider\_hcp) | 0.100.0 |
| <a name="provider_postgresql"></a> [postgresql](#provider\_postgresql) | 1.25.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_postgres"></a> [postgres](#module\_postgres) | terraform-aws-modules/rds/aws | 6.10.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bootstrap_workspace_name"></a> [bootstrap\_workspace\_name](#input\_bootstrap\_workspace\_name) | The name of bootstrap workspace | `string` | n/a | yes |
| <a name="input_database_allocated_storage"></a> [database\_allocated\_storage](#input\_database\_allocated\_storage) | The allocation storage size of database instance | `number` | `20` | no |
| <a name="input_database_engine"></a> [database\_engine](#input\_database\_engine) | The name of database engine | `string` | `"postgres"` | no |
| <a name="input_database_engine_version"></a> [database\_engine\_version](#input\_database\_engine\_version) | The version of database instance | `string` | `"16.4"` | no |
| <a name="input_database_family"></a> [database\_family](#input\_database\_family) | The family of database instance | `string` | `"postgres16"` | no |
| <a name="input_database_identifier_prefix"></a> [database\_identifier\_prefix](#input\_database\_identifier\_prefix) | The prefix name of for database instance | `string` | `"safepass-sentinel"` | no |
| <a name="input_database_instance_class"></a> [database\_instance\_class](#input\_database\_instance\_class) | The instance class of database instance | `string` | `"db.t3.micro"` | no |
| <a name="input_database_manage_master_user_password"></a> [database\_manage\_master\_user\_password](#input\_database\_manage\_master\_user\_password) | Determinate to manage master user password or not | `bool` | `false` | no |
| <a name="input_database_port"></a> [database\_port](#input\_database\_port) | The port of database instance | `number` | `5432` | no |
| <a name="input_database_publicly_accessible"></a> [database\_publicly\_accessible](#input\_database\_publicly\_accessible) | Determinates to expose database publicly or not | `bool` | `true` | no |
| <a name="input_database_skip_final_snapshot"></a> [database\_skip\_final\_snapshot](#input\_database\_skip\_final\_snapshot) | Determinate to skip the final snapshot or not | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_name"></a> [db\_name](#output\_db\_name) | The database name |
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The db instance endpoint |
| <a name="output_password"></a> [password](#output\_password) | The db master password |
| <a name="output_port"></a> [port](#output\_port) | The db instance port |
| <a name="output_username"></a> [username](#output\_username) | The db master username |
<!-- END_TF_DOCS -->
