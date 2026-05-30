# setup

This document describes the local composite action to set up the **Verge CLI** on the runner.

Action file: [../../../../.github/actions/verge/setup/action.yaml](../../../../.github/actions/verge/setup/action.yaml)

## Purpose

Downloads and installs a specific version of the Verge CLI on the runner, making it globally available in the path.

## When To Use

Use this action to manually install and initialize Verge CLI on your runner so you can call `verge` commands directly in subsequent workflow steps.

## Usage

```yaml
- name: Set up Verge CLI
  uses: ./.github/actions/verge/setup
  with:
    version: v0.1.8
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `version` | No | empty string | The specific version of Verge to install (e.g. `v0.1.8` or `0.1.8`). Defaults to the latest available version if omitted. |

## Notes

- Uses a cross-platform installation script to support Linux, macOS, and Windows.
- Automatically exports the `VERGE_VERSION` environment variable during the download process to request the specific version from GitHub Releases.
