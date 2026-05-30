# delete-state

This document describes the local composite action to delete a Terraform state file or storage blob.

Action file: [../../../../.github/actions/terraform/delete-state/action.yaml](../../../../.github/actions/terraform/delete-state/action.yaml)

## Purpose

Detects the backend type from the Terraform configuration (`local` or `azurerm`) and deletes the statefile from the appropriate backend storage.

## When To Use

Use this action during teardown or cleanup workflows when deleting a statefile is necessary to reset or decommission an environment.

## Usage

```yaml
- name: Delete Terraform statefile
  uses: ./.github/actions/terraform/delete-state
  with:
    configuration: example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |

## Notes

- Detects the backend type dynamically via `terraform -chdir=... show -json | jq -r '.backend.type'`.
- Supports deleting `local` state files by finding the configured path and running `rm -f`.
- Supports deleting `azurerm` state blobs using `az storage blob delete` with the resource group, storage account, container, and key details extracted from the state.
