## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                            | Type     |
| ----------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_storage_bucket.gopass_freyja_desarrollo](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |

## Inputs

| Name                                                   | Description                                                      | Type     | Default | Required |
| ------------------------------------------------------ | ---------------------------------------------------------------- | -------- | ------- | :------: |
| <a name="input_project"></a> [project](#input_project) | El proyecto en gcloud al que se van a asociar todos los recursos | `string` | n/a     |   yes    |
| <a name="input_region"></a> [region](#input_region)    | La región donde queda el storage bucket                          | `string` | n/a     |   yes    |

## Outputs

No outputs.
