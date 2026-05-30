# validate

This document describes the local composite action to validate Terraform configurations.

Action file: [../../../.github/actions/terraform/validate/action.yaml](../../../.github/actions/terraform/validate/action.yaml)

## Purpose

Initializes a configuration without a backend and runs a syntax and consistency validation on it.

## When To Use

Use this action in pull requests or static analysis workflows to ensure the Terraform code is syntactically correct and internally consistent.

## Usage

```yaml
- name: Terraform validate
  uses: ./.github/actions/terraform/validate
  with:
    configuration: example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |

## Notes

- Runs `terraform -chdir=terraform/configurations/<configuration> init -backend=false`.
- Runs `terraform -chdir=terraform/configurations/<configuration> validate`.
