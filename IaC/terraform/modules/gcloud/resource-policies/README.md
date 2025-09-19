## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                       | Type     |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_compute_resource_policy.start_stop_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy) | resource |

## Inputs

| Name                                                                        | Description                                                       | Type     | Default | Required |
| --------------------------------------------------------------------------- | ----------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_region"></a> [region](#input_region)                         | Región donde se deja la politica de recursos.                     | `string` | n/a     |   yes    |
| <a name="input_start_schedule"></a> [start_schedule](#input_start_schedule) | Horario de prendido de la maquina en fromato cron.                | `string` | n/a     |   yes    |
| <a name="input_stop_schedule"></a> [stop_schedule](#input_stop_schedule)    | Horario de apagado de la maquina en fromato cron.                 | `string` | n/a     |   yes    |
| <a name="input_sufix"></a> [sufix](#input_sufix)                            | Sufijo con el que se decora el nombre de la politica de recursos. | `string` | n/a     |   yes    |

## Outputs

| Name                                                                                   | Description                                               |
| -------------------------------------------------------------------------------------- | --------------------------------------------------------- |
| <a name="output_start_stop_policy"></a> [start_stop_policy](#output_start_stop_policy) | Link de referencia para la politica de recursos schedule. |
