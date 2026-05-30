# lint

This document describes the local composite action to perform tflint linting.

Action file: [../../../.github/actions/terraform/lint/action.yaml](../../../.github/actions/terraform/lint/action.yaml)

## Purpose

Runs the standard Terraform linter (`tflint`) to check for errors, deprecations, and best practice violations.

## When To Use

Use this action in pull requests or CI deployment pipelines to catch coding issues or Azure/AWS-specific integration problems.

## Usage

```yaml
- name: Terraform lint
  uses: ./.github/actions/terraform/lint
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

- Runs `tflint --chdir=terraform/configurations/<configuration> --minimum-failure-severity=error --var-file=env/<environment>.tfvars`.
