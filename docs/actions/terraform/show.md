# show

This document describes the local composite action to inspect Terraform state or plan.

Action file: [../../../.github/actions/terraform/show/action.yaml](../../../.github/actions/terraform/show/action.yaml)

## Purpose

Inspects and outputs the current state or a plan file.

## When To Use

Use this action when you need to print a human-readable representation of the current Terraform state.

## Usage

```yaml
- name: Terraform show
  uses: ./.github/actions/terraform/show
  with:
    configuration: example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |

## Notes

- Runs `terraform -chdir=terraform/configurations/<configuration> show`.
