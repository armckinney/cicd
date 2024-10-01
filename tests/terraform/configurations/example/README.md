<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_time"></a> [time](#requirement\_time) | 0.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_time"></a> [time](#provider\_time) | 0.12.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_this_file"></a> [this\_file](#module\_this\_file) | ../../modules/example | n/a |

## Resources

| Name | Type |
|------|------|
| [time_static.this](https://registry.terraform.io/providers/hashicorp/time/0.12.0/docs/resources/static) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Name of environment to deploy to. | `string` | n/a | yes |
| <a name="input_file_time"></a> [file\_time](#input\_file\_time) | Timestamp to place in file name. | `string` | n/a | yes |
| <a name="input_file_type"></a> [file\_type](#input\_file\_type) | Type of file to create. | `string` | `"txt"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_file_path"></a> [file\_path](#output\_file\_path) | n/a |
<!-- END_TF_DOCS -->