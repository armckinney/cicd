# apply

This document describes the local composite action to apply Terraform changes.

Action file: [../../../../.github/actions/terraform/apply/action.yaml](../../../../.github/actions/terraform/apply/action.yaml)

## Purpose

Applies the changes required to reach the desired state of the configuration, using automatic approval.

## When To Use

Use this action in CD pipelines or deployment stages where changes should be automatically provisioned.

## Usage

```yaml
- name: Terraform apply
  uses: ./.github/actions/terraform/apply
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

- Runs `terraform -chdir=terraform/configurations/<configuration> apply -auto-approve -var-file=env/<environment>.tfvars`.
