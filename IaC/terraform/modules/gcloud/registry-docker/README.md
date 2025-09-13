## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                      | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_artifact_registry_repository.native_registry_docker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository) | resource |

## Inputs

| Name                                                                     | Description                                                               | Type     | Default | Required |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_description"></a> [description](#input_description)       | Descripción asociada al registry.                                         | `string` | n/a     |   yes    |
| <a name="input_env"></a> [env](#input_env)                               | El entorno al que se le asigna el registry.                               | `string` | n/a     |   yes    |
| <a name="input_location"></a> [location](#input_location)                | La región donde queda el artifact registry                                | `string` | n/a     |   yes    |
| <a name="input_project"></a> [project](#input_project)                   | El name del proyecto en gcloud al que se van a asociar todos los recursos | `string` | n/a     |   yes    |
| <a name="input_repository_id"></a> [repository_id](#input_repository_id) | Id del docker registry a crear.                                           | `string` | n/a     |   yes    |

## Outputs

No outputs.
