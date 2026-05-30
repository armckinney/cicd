# plan

This document describes the local composite action to generate a Terraform execution plan.

Action file: [../../../../.github/actions/terraform/plan/action.yaml](../../../../.github/actions/terraform/plan/action.yaml)

## Purpose

Generates a Terraform execution plan, showing what actions Terraform will take to reach the desired state.

## When To Use

Use this action in pull requests or CI pipelines to inspect infrastructure changes before applying them.

## Usage

```yaml
- name: Terraform plan
  uses: ./.github/actions/terraform/plan
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

- Runs `terraform -chdir=terraform/configurations/<configuration> plan -var-file=env/<environment>.tfvars`.
