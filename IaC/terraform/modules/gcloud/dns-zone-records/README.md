## Requirements

No requirements.

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_google"></a> [google](#provider_google) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                        | Type     |
| ------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [google_dns_managed_zone.dns_managed_zone](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_record_set.a](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set)                    | resource |
| [google_dns_record_set.cname](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set)                | resource |

## Inputs

| Name                                                                     | Description                              | Type                                                                  | Default | Required |
| ------------------------------------------------------------------------ | ---------------------------------------- | --------------------------------------------------------------------- | ------- | :------: |
| <a name="input_a_records"></a> [a_records](#input_a_records)             | Registros A que se van a configurar.     | <pre>list(object({<br> name = string<br> ip = string<br> }))</pre>    | n/a     |   yes    |
| <a name="input_cname_records"></a> [cname_records](#input_cname_records) | Registros CNAME que se van a configurar. | <pre>list(object({<br> name = string<br> alias = string<br> }))</pre> | n/a     |   yes    |
| <a name="input_domain"></a> [domain](#input_domain)                      | Dominio que se va a administrar.         | `string`                                                              | n/a     |   yes    |

## Outputs

No outputs.
