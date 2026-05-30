# destroy

This document describes the local composite action to destroy Terraform-managed infrastructure.

Action file: [../../../../.github/actions/terraform/destroy/action.yaml](../../../../.github/actions/terraform/destroy/action.yaml)

## Purpose

Destroys all infrastructure managed by the specified configuration, using automatic approval.

## When To Use

Use this action in teardown pipelines or cleanups where environment infrastructure needs to be decommissioned.

## Usage

```yaml
- name: Terraform destroy
  uses: ./.github/actions/terraform/destroy
  with:
    configuration: example
    environment: dev
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |
| `environment` | Yes | - | Configuration environment. |

## Notes

- Runs `terraform -chdir=terraform/configurations/<configuration> destroy -auto-approve -var-file=env/<environment>.tfvars`.
