## Requirements

| Name                                                            | Version |
| --------------------------------------------------------------- | ------- |
| <a name="requirement_google"></a> [google](#requirement_google) | 5.38.0  |

## Providers

No providers.

## Modules

| Name                                                                                                        | Source                                  | Version |
| ----------------------------------------------------------------------------------------------------------- | --------------------------------------- | ------- |
| <a name="module_database"></a> [database](#module_database)                                                 | ../../modules/gcloud/database           | n/a     |
| <a name="module_develop_patch_deployment"></a> [develop_patch_deployment](#module_develop_patch_deployment) | ../../modules/gcloud/patch-deployment   | n/a     |
| <a name="module_instance_templates"></a> [instance_templates](#module_instance_templates)                   | ../../modules/gcloud/instance-templates | n/a     |
| <a name="module_network"></a> [network](#module_network)                                                    | ../../modules/gcloud/vpc                | n/a     |
| <a name="module_network_firewall"></a> [network_firewall](#module_network_firewall)                         | ../../modules/gcloud/firewall           | n/a     |
| <a name="module_public_ips"></a> [public_ips](#module_public_ips)                                           | ../../modules/gcloud/public-ips         | n/a     |
| <a name="module_vm"></a> [vm](#module_vm)                                                                   | ../../modules/gcloud/vm                 | n/a     |

## Resources

No resources.

## Inputs

| Name                                                                                                                                                               | Description                                                                              | Type     | Default                                                          | Required |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- | -------- | ---------------------------------------------------------------- | :------: |
| <a name="input_credentials_file"></a> [credentials_file](#input_credentials_file)                                                                                  | El archivo de credenciales del usuario con el que se realiza la configuración            | `string` | `"../../../.secure_files/MEDISUPPLY_TERRAFORM_ACCOUNT_KEY.json"` |    no    |
| <a name="input_dbadmin_password"></a> [dbadmin_password](#input_dbadmin_password)                                                                                  | La contraseña del usuario administrador de la base de datos.                             | `string` | n/a                                                              |   yes    |
| <a name="input_gce_ssh_pub_key_file"></a> [gce_ssh_pub_key_file](#input_gce_ssh_pub_key_file)                                                                      | Llave publica que se instala en las maquinas de la flota para poder ingresarlas por ssh. | `string` | `"../../../.secure_files/key_devops_medisupply_dev_ecdsa.pub"`   |    no    |
| <a name="input_gitlab_runner_ip"></a> [gitlab_runner_ip](#input_gitlab_runner_ip)                                                                                  | La IP del gitlab-runner que esta configurando las máquinas                               | `string` | `"35.237.120.170"`                                               |    no    |
| <a name="input_project"></a> [project](#input_project)                                                                                                             | El proyecto en gcloud al que se van a asociar todos los recursos                         | `string` | `"medisupply"`                                                   |    no    |
| <a name="input_region"></a> [region](#input_region)                                                                                                                | La región donde queda la subnet principal de la vpc                                      | `string` | `"us-east1"`                                                     |    no    |
| <a name="input_tls_self_signed_cert_and_private_key_folder"></a> [tls_self_signed_cert_and_private_key_folder](#input_tls_self_signed_cert_and_private_key_folder) | Llave privada para el certificado de los balanceadores de carga.                         | `string` | `"../../../.secure_files"`                                       |    no    |
| <a name="input_zone"></a> [zone](#input_zone)                                                                                                                      | La zona donde quedan las máquinas de la subnet principal de la vpc                       | `string` | `"us-east1-b"`                                                   |    no    |

## Outputs

No outputs.
