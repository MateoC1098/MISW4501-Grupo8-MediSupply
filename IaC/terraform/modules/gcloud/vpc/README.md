## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                      | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_compute_global_address.private_ip_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_global_address) | resource |
| [google_compute_network.compute_network](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network)                  | resource |
| [google_compute_subnetwork.compute_subnetwork](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork)         | resource |

## Inputs

| Name                                                                                          | Description                                                                                                                                        | Type     | Default      | Required |
| --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- | -------- | ------------ | :------: |
| <a name="input_filter_expr"></a> [filter_expr](#input_filter_expr)                            | Export filter used to define which VPC flow logs should be logged, as as CEL expression. See https://cloud.google.com/vpc/docs/flow-logs#filtering | `string` | `null`       |    no    |
| <a name="input_ip_cidr_range"></a> [ip_cidr_range](#input_ip_cidr_range)                      | El rango de direcciones internas que pertenecen a la subred principal de la vpc.                                                                   | `string` | n/a          |   yes    |
| <a name="input_log_subnetwork"></a> [log_subnetwork](#input_log_subnetwork)                   | Si se debe almacenar logs del trafico de la subred principal.                                                                                      | `bool`   | `false`      |    no    |
| <a name="input_network_name"></a> [network_name](#input_network_name)                         | El nombre de la vpc.                                                                                                                               | `string` | n/a          |   yes    |
| <a name="input_network_routing_mode"></a> [network_routing_mode](#input_network_routing_mode) | El modo de routing a usar, [REGIONAL, GLOBAL]                                                                                                      | `string` | `"REGIONAL"` |    no    |
| <a name="input_region"></a> [region](#input_region)                                           | La región donde queda la subred principal de la vpc.                                                                                               | `string` | n/a          |   yes    |
| <a name="input_subnetwork_name"></a> [subnetwork_name](#input_subnetwork_name)                | El nombre de la subred principal de la vpc.                                                                                                        | `string` | n/a          |   yes    |
| <a name="input_vpc_peering"></a> [vpc_peering](#input_vpc_peering)                            | Se requiere VPC perring para la red de una base de datos.                                                                                          | `bool`   | n/a          |   yes    |

## Outputs

| Name                                                                                      | Description                                                               |
| ----------------------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| <a name="output_network_id"></a> [network_id](#output_network_id)                         | El ID de la red VPC creada.                                               |
| <a name="output_private_ip_address"></a> [private_ip_address](#output_private_ip_address) | El nombre de la dirección privada que se compartira con la base de datos. |
| <a name="output_subnetwork_id"></a> [subnetwork_id](#output_subnetwork_id)                | El ID de la subred principal de la red VPC creada.                        |
