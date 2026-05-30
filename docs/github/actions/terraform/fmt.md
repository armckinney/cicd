# fmt

This document describes the local composite action to check Terraform formatting.

Action file: [../../../../.github/actions/terraform/fmt/action.yaml](../../../../.github/actions/terraform/fmt/action.yaml)

## Purpose

Validates if all Terraform files in the configuration are formatted according to canonical guidelines.

## When To Use

Use this action in linting or static analysis jobs (usually triggered on pull requests) to enforce formatting standards.

## Usage

```yaml
- name: Terraform format check
  uses: ./.github/actions/terraform/fmt
  with:
    configuration: example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |

## Notes

- Runs `terraform -chdir=terraform/configurations/<configuration> fmt -check`.
- Fails the build step if files are improperly formatted.
