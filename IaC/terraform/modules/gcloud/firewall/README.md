## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                 | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_compute_firewall.allow_health_checksn_ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.close_ssh_ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)            | resource |
| [google_compute_firewall.close_ssh_ipv6](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)            | resource |
| [google_compute_firewall.external_out](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)              | resource |
| [google_compute_firewall.http_server_ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)          | resource |
| [google_compute_firewall.http_server_ipv6](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)          | resource |
| [google_compute_firewall.https_server_ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)         | resource |
| [google_compute_firewall.https_server_ipv6](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)         | resource |
| [google_compute_firewall.iap_in_ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)               | resource |
| [google_compute_firewall.iap_in_ipv6](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)               | resource |
| [google_compute_firewall.internal_in](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)               | resource |
| [google_compute_firewall.internal_out](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)              | resource |
| [google_compute_firewall.open_custom_ssh_ipv4](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)      | resource |
| [google_compute_firewall.open_custom_ssh_ipv6](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall)      | resource |

## Inputs

| Name                                                                                                                  | Description                                                                                                            | Type           | Default   | Required |
| --------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | -------------- | --------- | :------: |
| <a name="input_authorized_ingress_cidr_IPv4"></a> [authorized_ingress_cidr_IPv4](#input_authorized_ingress_cidr_IPv4) | Las IPv4s desde donde se va poder acceder a las maquinas del proyecto.                                                 | `list(string)` | `[]`      |    no    |
| <a name="input_authorized_ingress_cidr_IPv6"></a> [authorized_ingress_cidr_IPv6](#input_authorized_ingress_cidr_IPv6) | Las IPv6s desde donde se va poder acceder a las maquinas del proyecto.                                                 | `list(string)` | `[]`      |    no    |
| <a name="input_close_22_port"></a> [close_22_port](#input_close_22_port)                                              | Si se cierra el puerto 22 para evitar spam sobre las maquinas.                                                         | `bool`         | `false`   |    no    |
| <a name="input_extra_dev_ports"></a> [extra_dev_ports](#input_extra_dev_ports)                                        | Los otros puertos que se habilitan para acceder desde las redes autorizadas, con el porposito de usarse en desarrollo. | `list(string)` | `[]`      |    no    |
| <a name="input_ip_cidr_range"></a> [ip_cidr_range](#input_ip_cidr_range)                                              | El rango de direcciones internas a las que se les va a permitir todo el trafico entre ellas.                           | `string`       | n/a       |   yes    |
| <a name="input_network_id"></a> [network_id](#input_network_id)                                                       | La red donde quedan las maquinas                                                                                       | `string`       | n/a       |   yes    |
| <a name="input_open_custom_ssh_port"></a> [open_custom_ssh_port](#input_open_custom_ssh_port)                         | Si se abre el puerto personalizado de ssh al internet publico.                                                         | `bool`         | `false`   |    no    |
| <a name="input_ssh_custom_port"></a> [ssh_custom_port](#input_ssh_custom_port)                                        | El puerto al que se redirecciona sshd para evitar spam sobre las maquinas.                                             | `string`       | `"56789"` |    no    |
| <a name="input_target_tag"></a> [target_tag](#input_target_tag)                                                       | El tag sobre el que se van a aplicar estas reglas de firewall.                                                         | `string`       | n/a       |   yes    |

## Outputs

No outputs.
