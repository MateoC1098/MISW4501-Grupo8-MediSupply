## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                     | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_compute_address.compute_address](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address) | resource |

## Inputs

| Name                                                                  | Description                                                      | Type                                                                                         | Default | Required |
| --------------------------------------------------------------------- | ---------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | ------- | :------: |
| <a name="input_expected_ips"></a> [expected_ips](#input_expected_ips) | El conjunto de IP publicas a separar para el proyecto.           | <pre>list(object({<br> name = string<br> description = string<br> env = string<br> }))</pre> | n/a     |   yes    |
| <a name="input_project"></a> [project](#input_project)                | El proyecto en gcloud al que se van a asociar todos los recursos | `string`                                                                                     | n/a     |   yes    |
| <a name="input_region"></a> [region](#input_region)                   | La región donde se separan las IPs.                              | `string`                                                                                     | n/a     |   yes    |

## Outputs

| Name                                                                    | Description                              |
| ----------------------------------------------------------------------- | ---------------------------------------- |
| <a name="output_ip_addresses"></a> [ip_addresses](#output_ip_addresses) | Un arreglo con cada dirección IP creada. |
