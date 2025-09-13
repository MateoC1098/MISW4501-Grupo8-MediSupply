## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                       | Type     |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_service_networking_connection.networking_connection](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_networking_connection) | resource |
| [google_sql_database_instance.database_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance)                     | resource |
| [google_sql_user.sql_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user)                                                        | resource |

## Inputs

| Name                                                                                                   | Description                                                                                  | Type                                                                 | Default                                 | Required |
| ------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------- | --------------------------------------- | :------: |
| <a name="input_authorizednets"></a> [authorizednets](#input_authorizednets)                            | El conjunto de redes autorizadas para comunicarse con la DB.                                 | <pre>list(object({<br> name = string<br> cidr = string<br> }))</pre> | n/a                                     |   yes    |
| <a name="input_built_in_admin_password"></a> [built_in_admin_password](#input_built_in_admin_password) | La contraseña del usuario tipo BUILT_IN que se crean con la base de datos.                   | `string`                                                             | `null`                                  |    no    |
| <a name="input_built_in_admin_user"></a> [built_in_admin_user](#input_built_in_admin_user)             | El usuario tipo BUILT_IN que se crean con la base de datos.                                  | `string`                                                             | `null`                                  |    no    |
| <a name="input_database_version"></a> [database_version](#input_database_version)                      | La versión a usar de la base de                                                              | `string`                                                             | n/a                                     |   yes    |
| <a name="input_deletion_protection"></a> [deletion_protection](#input_deletion_protection)             | Si se debe proteger la base de datos de ser eliminada.                                       | `bool`                                                               | `true`                                  |    no    |
| <a name="input_disk_autoresize_limit"></a> [disk_autoresize_limit](#input_disk_autoresize_limit)       | El maximo valor en GB que se permitira crecer al disco. Cuando es 0, no se establece limite. | `number`                                                             | `0`                                     |    no    |
| <a name="input_env"></a> [env](#input_env)                                                             | El entorno al que se le asigna la instancia sql.                                             | `string`                                                             | n/a                                     |   yes    |
| <a name="input_name"></a> [name](#input_name)                                                          | El nombre de la instancia.                                                                   | `string`                                                             | n/a                                     |   yes    |
| <a name="input_private_network"></a> [private_network](#input_private_network)                         | La red privada a la que se conectara la instancia.                                           | `string`                                                             | `null`                                  |    no    |
| <a name="input_region"></a> [region](#input_region)                                                    | La región donde queda la vpc                                                                 | `string`                                                             | n/a                                     |   yes    |
| <a name="input_reserved_peering_range"></a> [reserved_peering_range](#input_reserved_peering_range)    | El rango de la red privada a la que se conectara la instancia.                               | `string`                                                             | `null`                                  |    no    |
| <a name="input_ssl_mode"></a> [ssl_mode](#input_ssl_mode)                                              | El modo ssl para establecer conexiones.                                                      | `string`                                                             | `"TRUSTED_CLIENT_CERTIFICATE_REQUIRED"` |    no    |
| <a name="input_tier"></a> [tier](#input_tier)                                                          | El tipo de maquina a utilizar para alocar la instancia.                                      | `string`                                                             | n/a                                     |   yes    |

## Outputs

No outputs.
