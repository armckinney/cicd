# docs

This document describes the local composite action to generate and verify Terraform documentation.

Action file: [../../../.github/actions/terraform/docs/action.yaml](../../../.github/actions/terraform/docs/action.yaml)

## Purpose

Generates auto-generated module documentation via `terraform-docs` and compares it with the configuration's `README.md` to ensure they are identical and up-to-date.

## When To Use

Use this action in static analysis jobs to enforce that developers update documentation when making changes to inputs, outputs, or resources.

## Usage

```yaml
- name: Terraform docs
  uses: ./.github/actions/terraform/docs
  with:
    configuration: example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |

## Notes

- Runs `terraform-docs --output-file TERRAFORM_DOCS.md terraform/configurations/`.
- Compares `terraform/configurations/<configuration>/TERRAFORM_DOCS.md` with `terraform/configurations/<configuration>/README.md` using `cmp`.
- Fails the build if the auto-generated documentation is out of sync with `README.md`.
