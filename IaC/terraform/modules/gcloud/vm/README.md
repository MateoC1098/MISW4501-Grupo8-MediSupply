## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                                            | Type        |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [google_compute_disk.compute_disk](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk)                                                                 | resource    |
| [google_compute_disk_resource_policy_attachment.disk_policy_attachment](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk_resource_policy_attachment) | resource    |
| [google_compute_instance.compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance)                                                     | resource    |
| [google_compute_resource_policy.snapshot_policy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy)                                        | resource    |
| [google_service_account.vms_account](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/service_account)                                                         | data source |

## Inputs

| Name                                                                                                   | Description                                                                              | Type           | Default | Required |
| ------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------- | -------------- | ------- | :------: |
| <a name="input_cidr"></a> [cidr](#input_cidr)                                                          | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_delete_boot_disk"></a> [delete_boot_disk](#input_delete_boot_disk)                      | n/a                                                                                      | `bool`         | n/a     |   yes    |
| <a name="input_deletion_protection"></a> [deletion_protection](#input_deletion_protection)             | Si se protege una instancia de su eliminación.                                           | `bool`         | `false` |    no    |
| <a name="input_diskname"></a> [diskname](#input_diskname)                                              | El nombre del disco de la máquina.                                                       | `string`       | `null`  |    no    |
| <a name="input_enable_snapshot_policy"></a> [enable_snapshot_policy](#input_enable_snapshot_policy)    | n/a                                                                                      | `bool`         | n/a     |   yes    |
| <a name="input_env"></a> [env](#input_env)                                                             | El entorno al que se le asigna la vm.                                                    | `string`       | n/a     |   yes    |
| <a name="input_gce_ssh_pub_key_file"></a> [gce_ssh_pub_key_file](#input_gce_ssh_pub_key_file)          | Llave publica que se instala en las maquinas de la flota para poder ingresarlas por ssh. | `string`       | n/a     |   yes    |
| <a name="input_image"></a> [image](#input_image)                                                       | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_machine_type"></a> [machine_type](#input_machine_type)                                  | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_metadata_startup_script"></a> [metadata_startup_script](#input_metadata_startup_script) | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_name"></a> [name](#input_name)                                                          | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_network_id"></a> [network_id](#input_network_id)                                        | La red donde quedan las maquinas                                                         | `string`       | n/a     |   yes    |
| <a name="input_network_ip"></a> [network_ip](#input_network_ip)                                        | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_region"></a> [region](#input_region)                                                    | La region donde queda la vpc                                                             | `string`       | n/a     |   yes    |
| <a name="input_resource_policies"></a> [resource_policies](#input_resource_policies)                   | n/a                                                                                      | `list(string)` | n/a     |   yes    |
| <a name="input_size"></a> [size](#input_size)                                                          | n/a                                                                                      | `number`       | n/a     |   yes    |
| <a name="input_snapshot_start_time"></a> [snapshot_start_time](#input_snapshot_start_time)             | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_source_snapshot"></a> [source_snapshot](#input_source_snapshot)                         | n/a                                                                                      | `list(string)` | n/a     |   yes    |
| <a name="input_subnetwork_id"></a> [subnetwork_id](#input_subnetwork_id)                               | La subred donde quedan las maquinas                                                      | `string`       | n/a     |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                          | n/a                                                                                      | `list(string)` | n/a     |   yes    |
| <a name="input_type"></a> [type](#input_type)                                                          | n/a                                                                                      | `string`       | n/a     |   yes    |
| <a name="input_vms_account_id"></a> [vms_account_id](#input_vms_account_id)                            | La cuenta de servicio que va a ir asociada a las máquinas virtuales.                     | `string`       | n/a     |   yes    |
| <a name="input_zone"></a> [zone](#input_zone)                                                          | La zona donde queda la vpc                                                               | `string`       | n/a     |   yes    |

## Outputs

| Name                                                              | Description  |
| ----------------------------------------------------------------- | ------------ |
| <a name="output_machine_id"></a> [machine_id](#output_machine_id) | id de la VM. |
