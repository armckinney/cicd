# import

This document describes the local composite action to refresh resources and manage temporarily unhidden import definitions.

Action file: [../../../../.github/actions/terraform/import/action.yaml](../../../../.github/actions/terraform/import/action.yaml)

## Purpose

Temporarily unhides the `.imports.tf` file (by renaming it to `imports.tf`), runs `terraform refresh`, and safely hides the file back to `.imports.tf`.

## When To Use

Use this action when doing import-specific tasks to incorporate imported resources into the Terraform state file.

## Usage

```yaml
- name: Terraform import
  uses: ./.github/actions/terraform/import
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

- Renames `terraform/configurations/<configuration>/.imports.tf` to `imports.tf` before refreshing.
- Runs `terraform -chdir=... refresh -var-file=env/<environment>.tfvars`.
- Safely restores `.imports.tf` after execution (even if the refresh command fails).
