## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                            | Type     |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_os_config_patch_deployment.patch_deployment](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/os_config_patch_deployment) | resource |

## Inputs

| Name                                                                                             | Description                                                                               | Type           | Default | Required |
| ------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
| <a name="input_instances_URIs"></a> [instances_URIs](#input_instances_URIs)                      | Listado de instancias a las que se aplicaran los parches.                                 | `list(string)` | n/a     |   yes    |
| <a name="input_post_step_script_path"></a> [post_step_script_path](#input_post_step_script_path) | Ruta donde se puede encontrar el script que correra posterior a la aplicación del parche. | `string`       | n/a     |   yes    |
| <a name="input_pre_step_script_path"></a> [pre_step_script_path](#input_pre_step_script_path)    | Ruta donde se puede encontrar el script que correra previo a la aplicación del parche.    | `string`       | n/a     |   yes    |
| <a name="input_sufix"></a> [sufix](#input_sufix)                                                 | Sufijo con el que se decora el nombre del despliegue de parches en el proyecto.           | `string`       | n/a     |   yes    |

## Outputs

No outputs.
