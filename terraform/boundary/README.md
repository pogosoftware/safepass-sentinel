<!--- BEGIN_TF_DOCS --->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.7.0 |
| aws | ~> 5.39 |
| boundary | ~> 1.1 |
| hcp | ~> 0.83 |
| tls | ~> 4.0 |
| vault | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 5.39 |
| boundary | ~> 1.1 |
| hcp | ~> 0.83 |
| terraform | n/a |
| tls | ~> 4.0 |
| vault | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_region | The Name of AWS region | `string` | `"eu-central-1"` | no |
| bootstrap\_workspace\_name | The name of bootstrap workspace | `string` | n/a | yes |
| boundary\_ec2\_workers\_egress\_name | The name of Boundary egress worker | `string` | `"boundary-egress-worker"` | no |
| boundary\_ec2\_workers\_instance\_type | The type of Boundary worker instance | `string` | `"t2.micro"` | no |
| environment | The Name of environment. Possible values are: `dev`, `stg`, `prd` | `string` | `"dev"` | no |
| hcp\_boundary\_org\_description | The description of Boundary orgranization | `string` | `"Pogosoftware"` | no |
| hcp\_boundary\_org\_name | The name of Boundary organization | `string` | `"Pogosoftware"` | no |
| hcp\_boundary\_project\_description | The description of Boundary project | `string` | `"Contains develop resources for SafePass Sentinel project"` | no |
| hcp\_boundary\_project\_name | The name of Boundary project | `string` | `"SafePass Sentinel Develop"` | no |
| hcp\_project\_id | The UUID of HCP project | `string` | n/a | yes |
| sync\_interval\_seconds | Number of seconds between the time Boundary syncs hosts in this set | `number` | `60` | no |

## Outputs

No output.

<!--- END_TF_DOCS --->
