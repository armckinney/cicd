<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_local"></a> [local](#requirement\_local) | 2.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.this](https://registry.terraform.io/providers/hashicorp/local/2.5.1/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_directory"></a> [directory](#input\_directory) | Parent directory for the file. | `string` | n/a | yes |
| <a name="input_file_name"></a> [file\_name](#input\_file\_name) | Name of file. | `string` | n/a | yes |
| <a name="input_file_type"></a> [file\_type](#input\_file\_type) | Type of file to create. | `string` | `"txt"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file"></a> [file](#output\_file) | n/a |
<!-- END_TF_DOCS -->