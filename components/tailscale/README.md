# Component: `tailscale`

This component is responsible for provisioning [Tailscale](https://tailscale.com/) subnet routers in our AWS Accounts along with Tailscale resources required for this setup. This is to provide access to private services in AWS environment, e.g. RDS clusters.

## Usage

**Level**: Regional

Example: _TBD_

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.3 |
| aws | ~> 4.0 |
| sops | ~> 0.5 |
| tailscale | ~> 0.13.7 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 4.0 |
| sops | ~> 0.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| account | cloudposse/stack-config/yaml//modules/remote-state | 0.22.3 |
| ssh\_key\_pair | cloudposse/key-pair/aws | 0.18.3 |
| tailscale\_subnet\_router | git::https://github.com/masterpointio/terraform-aws-tailscale.git | tags/0.1.0 |
| this | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.ssm_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ssm_parameter) | data source |
| [aws_subnets.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [sops_file.sops_secrets](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_tag\_map | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`. This is for some rare cases where resources want additional configuration of tags and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| assume\_role\_override | Overrides the assumed role for the AWS provider. Useful for local testing and imports. | `string` | `null` | no |
| attributes | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`, in the order they appear in the list. New attributes are appended to the end of the list. The elements of the list are joined by the `delimiter` and treated as a single ID element. | `list(string)` | `[]` | no |
| context | Single object for setting entire context at once. See description of individual variables for details. Leave string and numeric variables as `null` to use default value. Individual variable settings (non-null) override settings in context object, except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | ```{ "additional_tag_map": {}, "attributes": [], "delimiter": null, "descriptor_formats": {}, "enabled": true, "environment": null, "id_length_limit": null, "label_key_case": null, "label_order": [], "label_value_case": null, "labels_as_tags": [ "unset" ], "name": null, "namespace": null, "regex_replace_chars": null, "stage": null, "tags": {}, "tenant": null }``` | no |
| delimiter | Delimiter to be used between ID elements. Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| descriptor\_formats | Describe additional descriptors to be output in the `descriptors` output map. Map of maps. Keys are names of descriptors. Values are maps of the form `{    format = string    labels = list(string) }` (Type is `any` so the map values can later be enhanced to provide additional options.) `format` is a Terraform format string to be passed to the `format()` function. `labels` is a list of labels, in order, to pass to `format()` function. Label values will be normalized before being passed to `format()` so they will be identical to how they appear in `id`. Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| enabled | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| environment | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| id\_length\_limit | Limit `id` to this many characters (minimum 6). Set to `0` for unlimited length. Set to `null` for keep the existing setting, which defaults to `0`. Does not affect `id_full`. | `number` | `null` | no |
| label\_key\_case | Controls the letter case of the `tags` keys (label names) for tags generated by this module. Does not affect keys of tags passed in via the `tags` input. Possible values: `lower`, `title`, `upper`. Default value: `title`. | `string` | `null` | no |
| label\_order | The order in which the labels (ID elements) appear in the `id`. Defaults to ["namespace", "environment", "stage", "name", "attributes"]. You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| label\_value\_case | Controls the letter case of ID elements (labels) as included in `id`, set as tag values, and output by this module individually. Does not affect values of tags passed in via the `tags` input. Possible values: `lower`, `title`, `upper` and `none` (no transformation). Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs. Default value: `lower`. | `string` | `null` | no |
| labels\_as\_tags | Set of labels (ID elements) to include as tags in the `tags` output. Default is to include all labels. Tags with empty values will not be included in the `tags` output. Set to `[]` to suppress all generated tags. **Notes:**   The value of the `name` tag, if included, will be the `id`, not the `name`.   Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be   changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | ```[ "default" ]``` | no |
| name | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'. This is the only ID element not also included as a `tag`. The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| namespace | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| regex\_replace\_chars | Terraform regular expression (regex) string. Characters matching the regex will be removed from the ID elements. If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| region | AWS region. | `string` | n/a | yes |
| run\_in\_cicd | If run in CI/CD platform, use terraform delegated role, otherwise use admin. | `bool` | `true` | no |
| secret\_mapping | The list of secret mappings the application will need. This creates secret values for the component to consume at `local.secrets[name]`. | ```list(object({ name = string type = string path = string file = string }))``` | `[]` | no |
| ssh\_public\_key\_file | Name of existing SSH public key file (e.g. `id_rsa.pub`) | `string` | `null` | no |
| ssh\_public\_key\_path | Path to SSH public key directory (e.g. `/secrets`) | `string` | n/a | yes |
| stage | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| tags | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`). Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| tailnet | The Tailnet to perform actions in. | `string` | n/a | yes |
| tailscale\_existing\_ssh\_key\_name | Use an existing EC2 key pair with this name, rather than importing a key pair. | `string` | `null` | no |
| tailscale\_session\_logging\_enabled | Tailscale Subnet Router session logging to S3. | `bool` | `true` | no |
| tenant | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| tailscale\_subnet\_route\_instance\_name | The name tag value of the Tailscale Subnet Router EC2 instance. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->