# init

This document describes the local composite action to initialize a Terraform configuration.

Action file: [../../../.github/actions/terraform/init/action.yaml](../../../.github/actions/terraform/init/action.yaml)

## Purpose

Initializes a Terraform configuration directory, supporting both backendless initialization and remote backend initialization.

## When To Use

Use this action to initialize a Terraform configuration configuration before running other operations like plan, apply, validation, or show.

## Usage

```yaml
- name: Terraform init
  uses: ./.github/actions/terraform/init
  with:
    configuration: example
    environment: dev
    backend: 'true'
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |
| `environment` | No | empty string | Configuration environment. Required if `backend` is `true`. |
| `backend` | No | `true` | Whether to initialize the backend (`true` or `false`). |

## Notes

- If `backend` is `true`, it runs `terraform -chdir=terraform/configurations/<configuration> init -backend-config=env/<environment>.tfbackend -reconfigure`.
- If `backend` is `false`, it runs `terraform -chdir=terraform/configurations/<configuration> init -backend=false`.
